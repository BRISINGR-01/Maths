# app.py
from flask import Flask, Response, render_template
import cv2
from app import create_env

app = Flask(__name__)

env = create_env(False)

@app.route('/')
def index():
  return render_template('index.html')  # HTML page to load image stream

@app.route('/video_feed')
def video_feed():
  def gen():
    while True:
      frame = env.render()
      _, buffer = cv2.imencode('.jpg', frame)
      yield (b'--frame\r\n'
        b'Content-Type: image/jpeg\r\n\r\n' + buffer.tobytes() + b'\r\n')
      action = env.action_space.sample()
      observation, reward, terminated, truncated, info = env.step(action)
      if terminated or truncated:
        observation, info = env.reset()

  return Response(gen(), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
  app.run(debug=True)
