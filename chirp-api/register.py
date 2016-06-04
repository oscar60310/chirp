# -*- coding: utf-8 -*-
import webapp2
import json
from google.appengine.api import urlfetch
from google.appengine.ext import db

class MainPage(webapp2.RequestHandler):
    def get(self):
      import sys
      reload(sys)
      sys.setdefaultencoding('utf8')
      token = self.request.get("token")
      email = self.request.get("email")
      self.response.headers['Content-Type'] = 'text/plain'
      if token == "" or email == "":
        self.response.write(json.dumps({"Statu" : "401"}))
      else:
        if not email.endswith("nsysu.edu.tw"):
          self.response.write(json.dumps({"Statu" : "403","Description" : "Email not allow"}))
        else:
          out = db.GqlQuery('SELECT * FROM Member WHERE SchoolMail = :1',email)
          if out.get() == None:
            url = 'https://graph.facebook.com/v2.6/debug_token?input_token=' + token + '&access_token=1608783402765050|a4bf3905aa24c68a90d33575e577e5af'
            response = urlfetch.fetch(url)
            data = json.loads(response.content)
            comfirm = False
            if 'data' in data:
              if 'app_id' in data['data']:
                if data['data']['app_id'] == '1608783402765050':
                  comfirm = True
            if not comfirm:
              self.response.write(json.dumps({"Statu" : "407","Description" : "Token comfirm fail."}))
             # print(data)
              return

            url = 'https://graph.facebook.com/v2.6/me?fields=id%2Cname%2Cemail%2Clast_name%2Cfirst_name&access_token='+token 
            response = urlfetch.fetch(url)
            if response.status_code == 200:
              html = json.loads(response.content)
              from google.appengine.api import mail
              import random 
              code = ''.join(random.sample('ABCDEFGHIJKLMNOPQRSTUVWXYZ',5))
              mail.send_mail(sender = "啁啾 <register@chirp-api.appspotmail.com>",
                   to = "%s <%s>" % (html["name"],email),
                   subject = "歡迎註冊啁啾",
                   body = """嗨，%s :
很高興再次見到您，請在您的應用程式中輸入 %s 來驗證您的電子郵件！

祝您使用愉快
啁啾""" % (html["first_name"],code))
              bukkit = EmailComfirm(email = email, token = token , code = code)
              bukkit.put()
              self.response.write(json.dumps({"Statu" : "200","Description" : "OK"}))
            else:
           	  self.response.write(json.dumps({"Statu" : "405","Description" : "Token not vail"}))
          else:
            self.response.write(json.dumps({"Statu" : "406","Description" : "Email registed."}))

          

      
        

app = webapp2.WSGIApplication([
    ('/register', MainPage),
], debug=True)

class EmailComfirm(db.Model):
  email = db.StringProperty()
  code = db.StringProperty()
  token = db.StringProperty()
class Member(db.Model):
  pass