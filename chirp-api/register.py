# -*- coding: utf-8 -*-
import webapp2
import json
from google.appengine.api import urlfetch

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

          url = 'https://graph.facebook.com/v2.6/me?fields=id%2Cname%2Cemail%2Clast_name%2Cfirst_name&access_token='+token 
          response = urlfetch.fetch(url)
          if response.status_code == 200:
            html = json.loads(response.content)
            from google.appengine.api import mail
            import random 
            code = ''.join(random.sample('ABCDEFGHIJKLMNOPQRSTUVWXYZ',5))
            mail.send_mail(sender = "<啁啾> register@chirp-api.appspotmail.com",
                   to = "%s <%s>" % (html["name"],email),
                   subject = "歡迎註冊啁啾",
                   body = """嗨，%s :
很高興再次見到您，請在您的應用程式中輸入 %s 來驗證您的電子郵件！

祝您使用愉快
啁啾""" % (html["first_name"],code))

            self.response.write(json.dumps({"Statu" : "200","Description" : "OK"}))
          else:
           	self.response.write(json.dumps({"Statu" : "405","Description" : "Token not vail"}))


          

      
        

app = webapp2.WSGIApplication([
    ('/register', MainPage),
], debug=True)