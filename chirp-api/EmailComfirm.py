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
          url = 'https://graph.facebook.com/v2.6/me?fields=id%2Cname%2Cfirst_name&access_token='+token 
          response = urlfetch.fetch(url)
          if response.status_code == 200:
            html = json.loads(response.content)
            mem = Member(SchoolMail = email, ComfirmDate = dates , FacebookToken = token , member_id = html['id'] , name = html['name'] , first_name = html['first_name'] , chirp_token = "---")
            mem.put()
            self.response.write(json.dumps({"Statu" : "200","Description" : "OK"}))
          else:
            self.response.write(json.dumps({"Statu" : "500","Description" : "Server error."}))
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
  member_id = db.StringProperty()
  name = db.StringProperty()
  first_name = db.StringProperty()
  chirp_token = db.StringProperty()