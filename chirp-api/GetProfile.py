# -*- coding: utf-8 -*-
import webapp2
import json
from google.appengine.api import urlfetch
from google.appengine.ext import db
import datetime

class Member(db.Model):
  member_id  = db.StringProperty()
  name = db.StringProperty()
  first_name = db.StringProperty()

class MainPage(webapp2.RequestHandler):
    def get(self):
      import sys
      reload(sys)
      sys.setdefaultencoding('utf8')
      token = self.request.get("token")
     
      out = db.GqlQuery('SELECT * FROM Member WHERE chirp_token = :1',token).get()
      if out == None:
        self.response.write(json.dumps({"Statu" : "403","Description" : "Token not vail."}))
        return
      self.response.write(json.dumps({"Statu" : "200","data" : {"id" : out.member_id , "name" : out.name , "first_name" : out.first_name}}))
       # self.response.write(json.dumps({"Statu" : "405","Description" : "Token not vail"}))
           
app = webapp2.WSGIApplication([
    ('/GetProfile', MainPage),
], debug=True)


