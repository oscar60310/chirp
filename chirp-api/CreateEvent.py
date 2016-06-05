# -*- coding: utf-8 -*-
import webapp2
import json
from google.appengine.api import urlfetch
from google.appengine.ext import db
import datetime

class MainPage(webapp2.RequestHandler):
    def post(self):
      import sys
      reload(sys)
      sys.setdefaultencoding('utf8')
      data = self.request.body
      try:
      if True:
        js = json.loads(data)
        token = js['token']
        out = db.GqlQuery('SELECT * FROM Member WHERE access_token = :1',token).get()
        if out == None:
          self.response.write(json.dumps({"Statu" : "402","Description" : "Token not vail."}))
          return 
        import uuid
        dates = datetime.datetime.now()
        idu =  str(uuid.uuid1())
        ev = (Event(create = out.id,id = idu, create_time = dates, data = json.dumps(js['data']), area = js['data']['area'],
          people_want = int(js['data']['people_num']) , people_now = 1))
        ev.put()
        self.response.write(json.dumps({"Statu" : "200","Description" : "OK.","Eventid": idu}))
      except:
        self.response.write(json.dumps({"Statu" : "401","Description" : "JSON load fail."}))
           
app = webapp2.WSGIApplication([
    ('/CreateEvent', MainPage),
], debug=True)


class Member(db.Model):
  id = db.StringProperty()
  pass
class Event(db.Model):
  create = db.StringProperty()
  id = db.StringProperty()
  create_time = db.DateTimeProperty()
  data = db.StringProperty()
  area = db.StringProperty()
  people_want = db.IntegerProperty()
  people_now = db.IntegerProperty()