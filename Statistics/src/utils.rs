use std::{
    collections::{HashMap, HashSet},
    f32::INFINITY,
};

pub static DATA_FILE: &str = "./data/survey_results_public.csv";
pub static SAMPLE_DATA_FILE: &str = "./data/sample_survey_results.csv";
pub static EXTRACTED_DATA_FILE: &str = "./data/extracted_results.csv";
pub static JSON_DATA_FILE: &str = "./data/data.json";
pub static SAMPLE_SIZE: usize = 10000;

#[derive(serde::Deserialize, serde::Serialize, Clone)]
pub struct Row {
    pub ResponseId: u32,
    pub MainBranch: String,
    pub YearsCode: String,
    pub YearsCodePro: String,
    pub JobSatPoints_7: String,
}

#[derive(serde::Deserialize, serde::Serialize, Clone)]
pub struct Data {
    pub category: String,
    pub years_code: u32,
    pub years_code_pro: u32,
    pub y: u32,
}

#[derive(serde::Deserialize, serde::Serialize, Clone)]
pub struct ReadyData {
    pub x: u32,
    pub y: u32,
}

fn size(x: &Vec<u32>) -> f64 {
    (x.len() - 1) as f64
}

pub fn mean(data: &Vec<u32>) -> f64 {
    let sum: u32 = data.iter().sum();
    let len = data.len() as u32;
    (sum / len) as f64
}

pub fn median(data: &Vec<u32>) -> f64 {
    let mut data = data.clone();
    data.sort();
    if data.len() % 2 == 0 {
        return (data[data.len() / 2] + data[data.len() / 2 - 1]) as f64 / 2.0;
    } else {
        return data[data.len() / 2] as f64;
    }
}

pub fn mode(data: &Vec<u32>) -> u32 {
    let mut map = HashMap::new();
    for el in data {
        let count = map.entry(el).or_insert(0);
        *count += 1;
    }
    let mut max = 0;
    let mut m = 0;
    for (&el, count) in map {
        if count > max {
            max = count;
            m = el;
        }
    }
    m
}

pub fn regression_line(x: &Vec<u32>, y: &Vec<u32>) -> (f64, f64) {
    let n = size(&x);
    let sum_x: u32 = x.iter().sum();
    let sum_y: u32 = y.iter().sum();
    let sum_xy: u32 = x.iter().zip(y.iter()).map(|(x, y)| x * y).sum();
    let sum_x2: u32 = x.iter().map(|x| x * x).sum();

    let slope = (sum_xy as f64 - (sum_x as f64 * sum_y as f64) / n)
        / (sum_x2 as f64 - (sum_x.pow(2) as f64) / n);

    let intercept = (sum_y as f64 - slope * sum_x as f64) / n;

    (slope, intercept)
}

pub fn sse(x: &Vec<u32>, y: &Vec<u32>, slope: f64, intercept: f64) -> f64 {
    x.iter()
        .zip(y.iter())
        .map(|(x, y)| ((*y as f64) - (slope * (*x as f64) + intercept)).powi(2))
        .sum()
}

pub fn mse(x: &Vec<u32>, y: &Vec<u32>, slope: f64, intercept: f64) -> f64 {
    sse(x, y, slope, intercept) / size(x)
}

pub fn rmse(x: &Vec<u32>, y: &Vec<u32>, slope: f64, intercept: f64) -> f64 {
    mse(x, y, slope, intercept).sqrt()
}

pub fn mae(x: &Vec<u32>, y: &Vec<u32>, slope: f64, intercept: f64) -> f64 {
    x.iter()
        .zip(y.iter())
        .map(|(x, y)| ((*y as f64) - (slope * (*x as f64) + intercept)).abs())
        .sum::<f64>()
        / size(x)
}

pub fn coef_determination(x: &Vec<u32>, y: &Vec<u32>, slope: f64, intercept: f64) -> f64 {
    let m = mean(y);

    1.0 - sse(x, y, slope, intercept) / y.iter().map(|y| (*y as f64 - m).powi(2)).sum::<f64>()
}

pub fn standard_deviation(x: &Vec<u32>) -> f64 {
    let m = mean(x);
    (x.iter().map(|x| (*x as f64 - m).powi(2)).sum::<f64>() / size(x)).sqrt()
}

pub fn q1(x: &Vec<u32>) -> u32 {
    let mut data = x.clone();
    data.sort();
    data[(data.len() / 4) - 1]
}

pub fn q3(x: &Vec<u32>) -> u32 {
    let mut data = x.clone();
    data.sort();
    data[(data.len() * 3 / 4) - 1]
}

pub fn iqr(x: &Vec<u32>) -> u32 {
    q3(x) - q1(x)
}

pub fn range(x: &Vec<u32>) -> f64 {
    let mut data = x.clone();
    data.sort();
    data[data.len() - 1] as f64 - data[0] as f64
}

pub fn min(x: &Vec<u32>) -> f64 {
    let mut data = x.clone();
    data.sort();
    data[0] as f64
}

pub fn max(x: &Vec<u32>) -> f64 {
    let mut data = x.clone();
    data.sort();
    data[data.len() - 1] as f64
}

pub fn outliers(x: &Vec<u32>) -> Vec<u32> {
    let border = iqr(x) as f64 * 1.5;
    let lower_border = q1(x) as f64 - border;
    let upper_border = q3(x) as f64 + border;

    let mut data = x.clone();
    data.sort();
    data.iter()
        .filter(|x| (**x as f64) < lower_border || (**x as f64) > upper_border)
        .into_iter()
        .collect::<HashSet<_>>()
        .into_iter()
        .copied()
        .collect()
}

pub fn spearman(x: &Vec<u32>, y: &Vec<u32>) -> f64 {
    let n = size(x);
    1 as f64 - (6 as f64 * spearman_d(x, y)) / (n * (n.powi(2) - 1 as f64))
}

fn spearman_d(x: &Vec<u32>, y: &Vec<u32>) -> f64 {
    spearman_points(x, y)
        .into_iter()
        .map(|(dx, dy)| (dx - dy).powi(2) as f64)
        .sum::<f64>()
}

pub fn spearman_z(x: &Vec<u32>, y: &Vec<u32>) -> f64 {
    let n = size(x);
    let d = spearman_d(x, y);
    let e = (n.powi(3) - n.powi(2)) / 6 as f64;
    let v = n.powi(2) * (n + 1 as f64).powi(2) * (n - 1 as f64).powi(2);

    (d - e) / v.sqrt()
}

pub fn spearman_points(x: &Vec<u32>, y: &Vec<u32>) -> Vec<(f64, f64)> {
    let n = x.len();

    let mut sorted_x = x.clone();
    sorted_x.sort();
    let mut sorted_y = y.clone();
    sorted_y.sort();

    let dx = x
        .iter()
        .map(|&p| {
            let i = sorted_x.iter().position(|&r| r == p).unwrap();
            sorted_x[i] = INFINITY as u32;
            i as f64
        })
        .collect::<Vec<f64>>();

    let dy = y
        .iter()
        .map(|&p| {
            let i = sorted_y.iter().position(|&r| r == p).unwrap();
            sorted_y[i] = INFINITY as u32;
            i as f64
        })
        .collect::<Vec<f64>>();

    let mut vec = Vec::with_capacity(n);

    for i in 0..n {
        vec.push((dx[i], dy[i]));
    }

    vec
}

pub const HEADERS: [&'static str; 114] = [
    "ResponseId",
    "MainBranch",
    "Age",
    "Employment",
    "RemoteWork",
    "Check",
    "CodingActivities",
    "EdLevel",
    "LearnCode",
    "LearnCodeOnline",
    "TechDoc",
    "YearsCode",
    "YearsCodePro",
    "DevType",
    "OrgSize",
    "PurchaseInfluence",
    "BuyNewTool",
    "BuildvsBuy",
    "TechEndorse",
    "Country",
    "Currency",
    "CompTotal",
    "LanguageHaveWorkedWith",
    "LanguageWantToWorkWith",
    "LanguageAdmired",
    "DatabaseHaveWorkedWith",
    "DatabaseWantToWorkWith",
    "DatabaseAdmired",
    "PlatformHaveWorkedWith",
    "PlatformWantToWorkWith",
    "PlatformAdmired",
    "WebframeHaveWorkedWith",
    "WebframeWantToWorkWith",
    "WebframeAdmired",
    "EmbeddedHaveWorkedWith",
    "EmbeddedWantToWorkWith",
    "EmbeddedAdmired",
    "MiscTechHaveWorkedWith",
    "MiscTechWantToWorkWith",
    "MiscTechAdmired",
    "ToolsTechHaveWorkedWith",
    "ToolsTechWantToWorkWith",
    "ToolsTechAdmired",
    "NEWCollabToolsHaveWorkedWith",
    "NEWCollabToolsWantToWorkWith",
    "NEWCollabToolsAdmired",
    "OpSysPersonal use",
    "OpSysProfessional use",
    "OfficeStackAsyncHaveWorkedWith",
    "OfficeStackAsyncWantToWorkWith",
    "OfficeStackAsyncAdmired",
    "OfficeStackSyncHaveWorkedWith",
    "OfficeStackSyncWantToWorkWith",
    "OfficeStackSyncAdmired",
    "AISearchDevHaveWorkedWith",
    "AISearchDevWantToWorkWith",
    "AISearchDevAdmired",
    "NEWSOSites",
    "SOVisitFreq",
    "SOAccount",
    "SOPartFreq",
    "SOHow",
    "SOComm",
    "AISelect",
    "AISent",
    "AIBen",
    "AIAcc",
    "AIComplex",
    "AIToolCurrently Using",
    "AIToolInterested in Using",
    "AIToolNot interested in Using",
    "AINextMuch more integrated",
    "AINextNo change",
    "AINextMore integrated",
    "AINextLess integrated",
    "AINextMuch less integrated",
    "AIThreat",
    "AIEthics",
    "AIChallenges",
    "TBranch",
    "ICorPM",
    "WorkExp",
    "Knowledge_1",
    "Knowledge_2",
    "Knowledge_3",
    "Knowledge_4",
    "Knowledge_5",
    "Knowledge_6",
    "Knowledge_7",
    "Knowledge_8",
    "Knowledge_9",
    "Frequency_1",
    "Frequency_2",
    "Frequency_3",
    "TimeSearching",
    "TimeAnswering",
    "Frustration",
    "ProfessionalTech",
    "ProfessionalCloud",
    "ProfessionalQuestion",
    "Industry",
    "JobSatPoints_1",
    "JobSatPoints_4",
    "JobSatPoints_5",
    "JobSatPoints_6",
    "JobSatPoints_7",
    "JobSatPoints_8",
    "JobSatPoints_9",
    "JobSatPoints_10",
    "JobSatPoints_11",
    "SurveyLength",
    "SurveyEase",
    "ConvertedCompYearly",
    "JobSat",
];
