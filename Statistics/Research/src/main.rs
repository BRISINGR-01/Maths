use csv::{Reader, StringRecord, Writer};
use json::object;
use rand::prelude::*;
use std::io::Write;
use std::{collections::HashMap, fs::File, vec};
use utils::{
    coef_determination, iqr, mae, max, mean, median, min, mode, mse, outliers, q1, q3, range,
    regression_line, rmse, sse, standard_deviation, Data, ReadyData, Row, DATA_FILE,
    EXTRACTED_DATA_FILE, HEADERS, JSON_DATA_FILE, SAMPLE_DATA_FILE, SAMPLE_SIZE,
};

mod utils;

fn main() {
    generate_sample_data();
    transform_data(get_sample_data());
    save_data_as_json();
}

fn get_full_data() -> Reader<File> {
    match csv::Reader::from_path(DATA_FILE) {
        Ok(reader) => reader,
        Err(e) => panic!("Error: {}", e),
    }
}

fn get_sample_data() -> Vec<Row> {
    let mut vec: Vec<Row> = Vec::new();
    let h = StringRecord::from(Vec::from(HEADERS));

    if let Ok(mut reader) = csv::Reader::from_path(SAMPLE_DATA_FILE) {
        for row in reader.records() {
            match row {
                Err(_) => continue,
                Ok(record) => {
                    let row: Row = record.deserialize(Some(&h)).unwrap();
                    vec.push(row.to_owned());
                }
            }
        }
    };

    return vec;
}

fn generate_sample_data() {
    let mut rng = rand::rng();

    let mut data: HashMap<String, Vec<StringRecord>> = HashMap::new();

    data.insert("I am a developer by profession".to_string(), vec![]);
    data.insert("I am learning to code".to_string(), vec![]);
    data.insert("I code primarily as a hobby".to_string(), vec![]);
    data.insert(
        "I am not primarily a developer, but I write code sometimes as part of my work/studies"
            .to_string(),
        vec![],
    );
    data.insert(
        "I used to be a developer by profession, but no longer am".to_string(),
        vec![],
    );

    let h = StringRecord::from(Vec::from(HEADERS));

    for row in get_full_data().records() {
        match row {
            Err(_) => continue,
            Ok(record) => {
                let record_row: Result<Row, csv::Error> = record.deserialize(Some(&h));
                if record_row.is_err() {
                    println!("{}", record.as_slice());
                    panic!("error: {}", record_row.err().unwrap());
                } else if rng.random_bool(0.5) {
                    let cat = &record_row.unwrap().MainBranch;

                    if let Some(vec) = data.get_mut(cat) {
                        if vec.len() < SAMPLE_SIZE {
                            vec.push(record.to_owned());
                        }
                    } else {
                        panic!("unknown: {}", cat);
                    }
                }
            }
        }

        if data.iter().all(|(_, vec)| vec.len() >= SAMPLE_SIZE) {
            break;
        }
    }

    let mut wtr = Writer::from_path(SAMPLE_DATA_FILE).unwrap();

    for (_, v) in data.iter() {
        for row in v {
            if let Err(e) = wtr.write_record(row) {
                panic!("{}", e);
            }
        }
    }

    wtr.flush().unwrap();
}

fn transform_data(data: Vec<Row>) {
    let mut wtr = Writer::from_path(EXTRACTED_DATA_FILE).unwrap();

    for row in data {
        if let Err(e) = wtr.serialize(Data {
            category: row.MainBranch,
            years_code: match row.YearsCode.parse::<u32>() {
                Ok(v) => v,
                Err(_e) => 0,
            },
            years_code_pro: match row.YearsCodePro.parse::<u32>() {
                Ok(v) => v,
                Err(_e) => 0,
            },
            y: match row.JobSatPoints_7.parse::<u32>() {
                Ok(v) => v,
                Err(_e) => 0,
            },
        }) {
            panic!("{}", e);
        }
    }

    wtr.flush().unwrap();
}

fn save_data_as_json() {
    let mut vec: Vec<ReadyData> = Vec::new();
    let h = StringRecord::from(vec!["category", "years_code", "years_code_pro", "y"]);

    if let Ok(mut reader) = csv::Reader::from_path(EXTRACTED_DATA_FILE) {
        for row in reader.records() {
            match row {
                Err(_) => continue,
                Ok(record) => {
                    let row: Data = record.deserialize(Some(&h)).unwrap();
                    if row.y == 0 || row.years_code_pro == 0 {
                        continue;
                    }

                    vec.push(ReadyData {
                        x: row.years_code_pro,
                        y: row.y,
                    });
                }
            }
        }
    };

    let (slope, inter) = regression_line(
        vec.iter().map(|d| d.x).collect(),
        vec.iter().map(|d| d.y).collect(),
    );

    let mut json_data = json::JsonValue::new_object();

    json_data["slope"] = slope.into();
    json_data["inter"] = inter.into();
    json_data["count"] = vec.len().into();
    json_data["sse"] = sse(
        &vec.iter().map(|d| d.x).collect(),
        &vec.iter().map(|d| d.y).collect(),
        slope,
        inter,
    )
    .into();
    json_data["mse"] = mse(
        &vec.iter().map(|d| d.x).collect(),
        &vec.iter().map(|d| d.y).collect(),
        slope,
        inter,
    )
    .into();
    json_data["rmse"] = rmse(
        &vec.iter().map(|d| d.x).collect(),
        &vec.iter().map(|d| d.y).collect(),
        slope,
        inter,
    )
    .into();
    json_data["mae"] = mae(
        &vec.iter().map(|d| d.x).collect(),
        &vec.iter().map(|d| d.y).collect(),
        slope,
        inter,
    )
    .into();
    json_data["r2"] = coef_determination(
        &vec.iter().map(|d| d.x).collect(),
        &vec.iter().map(|d| d.y).collect(),
        slope,
        inter,
    )
    .into();

    json_data["x_standard_deviation"] =
        standard_deviation(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_q1"] = q1(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_q3"] = q3(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_iqr"] = iqr(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_range"] = range(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_outliers"] = outliers(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_mean"] = mean(vec.iter().map(|d| d.x).collect()).into();
    json_data["x_median"] = median(vec.iter().map(|d| d.x).collect()).into();
    json_data["x_mode"] = mode(vec.iter().map(|d| d.x).collect()).into();
    json_data["x_min"] = min(&vec.iter().map(|d| d.x).collect()).into();
    json_data["x_max"] = max(&vec.iter().map(|d| d.x).collect()).into();
    json_data["y_standard_deviation"] =
        standard_deviation(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_q1"] = q1(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_q3"] = q3(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_iqr"] = iqr(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_range"] = range(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_outliers"] = outliers(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_mean"] = mean(vec.iter().map(|d| d.y).collect()).into();
    json_data["y_median"] = median(vec.iter().map(|d| d.y).collect()).into();
    json_data["y_mode"] = mode(vec.iter().map(|d| d.y).collect()).into();
    json_data["y_min"] = min(&vec.iter().map(|d| d.y).collect()).into();
    json_data["y_max"] = max(&vec.iter().map(|d| d.y).collect()).into();

    let json_data_vec: Vec<json::JsonValue> = vec
        .iter()
        .map(|p| {
            object! {
                x: p.x,
                y: p.y
            }
        })
        .collect();
    json_data["data"] = json_data_vec.into();

    let mut file = File::create(JSON_DATA_FILE).unwrap();
    file.write(json_data.dump().as_bytes()).unwrap();
}
