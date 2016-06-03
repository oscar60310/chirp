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
      email = self.request.get("email")
      code = self.request.get("code")
      self.response.headers['Content-Type'] = 'text/plain'
      if token == "" or email == "" or code == "":
        self.response.write(json.dumps({"Statu" : "401"}))
      else:
        out = db.GqlQuery('SELECT * FROM EmailComfirm WHERE token = :1 AND email = :2 AND code = :3',token,email,code)
        currect = False
        for p in out.run():
          currect = True
          p.delete()
        if currect:
          dates = datetime.datetime.now().date()
          mem = Member(SchoolMail = email, ComfirmDate = dates , FacebookToken = token)
          mem.put()
          self.response.write(json.dumps({"Statu" : "200","Description" : "OK"}))
        else:
          self.response.write(json.dumps({"Statu" : "402","Description" : "No Match."}))

app = webapp2.WSGIApplication([
    ('/EmailComfirm', MainPage),
], debug=True)

class EmailComfirm(db.Model):
  email = db.StringProperty()
  code = db.StringProperty()
  token = db.StringProperty()

class Member(db.Model):
  SchoolMail = db.StringProperty()
  ComfirmDate = db.DateProperty()
  FacebookToken = db.StringProperty()
