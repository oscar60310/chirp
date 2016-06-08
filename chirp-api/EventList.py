# -*- coding: utf-8 -*-
import webapp2
import json
from google.appengine.api import urlfetch
from google.appengine.ext import db
import datetime

class MainPage(webapp2.RequestHandler):
    def get(self):
      import sys
      reload(sys)
      sys.setdefaultencoding('utf8')
      token = self.request.get("token")
      out = db.GqlQuery('SELECT * FROM Token WHERE token = :1',token).get() 
      if out == None:
        self.response.write(json.dumps({"Statu" : "401","Description" : "TokenError."}))
      else:
        eve = db.GqlQuery('SELECT * FROM Event').run()
        data = []
        for en in eve:
          data.append({'id' : en.id , 'area' : en.area , 'title' : en.title})
        

        self.response.write(json.dumps({"Statu" : "200","Description" : "OK.", "data" :(data)}))

app = webapp2.WSGIApplication([
    ('/EventList', MainPage),
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
  title = db.StringProperty()
class Token(db.Model):
  pass
  