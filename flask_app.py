import datetime
import pystache
from flask import Flask

app = Flask(__name__)

renderer_obj = pystache.Renderer()

@app.route("/")
def hello():
   """
   """
   stache_hello = None

   with open('hello.mustache', 'r') as file_obj:
      stache_hello = file_obj.read()
   # htiw

   parsed_hello = pystache.parse(stache_hello)

   response_str = renderer_obj.render(
      parsed_hello,
      {'hello': "'sup, Gurl. | " + str(datetime.datetime.now())},
   )
   
   return (response_str)
# fed

if __name__ == "__main__":
   app.run(
      host='0.0.0.0',
      port='80',
   )
# fi
