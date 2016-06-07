# -*- coding: utf-8 -*-
import webapp2
import json
from google.appengine.api import urlfetch
from google.appengine.ext import db
import datetime
class Member(db.Model):
  SchoolMail = db.StringProperty()
  ComfirmDate = db.DateProperty()
  FacebookToken = db.StringProperty()
  member_id = db.StringProperty()
  name = db.StringProperty()
  first_name = db.StringProperty()
  chirp_token = db.StringProperty()
class MainPage(webapp2.RequestHandler):
    def get(self):
      import sys
      reload(sys)
      sys.setdefaultencoding('utf8')
      token = self.request.get("token")
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
        return
      url = 'https://graph.facebook.com/v2.6/me?fields=id%2Cname%2Cemail%2Clast_name%2Cfirst_name&access_token='+token 
      response = urlfetch.fetch(url)
      if response.status_code == 200:
        html = json.loads(response.content)
        id = html['id'] + ''
        out = db.GqlQuery('SELECT * FROM Member WHERE member_id = :1',id).run()
        ok = False
        #print out
        for out2 in out:
          try:
            ok = True
            import random 
            import string
            access = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(50))
            mem = Member(SchoolMail = out2.SchoolMail, ComfirmDate = out2.ComfirmDate , FacebookToken = out2.FacebookToken , member_id = out2.member_id, name = out2.name , first_name = out2.first_name , chirp_token = access)
            mem.put()
            out2.delete()
            self.response.write(json.dumps({"Statu" : "200","Description" : "OK.","access_token" : access}))
          except:
            pass
        if ok == False:
          self.response.write(json.dumps({"Statu" : "403","Description" : "ID not registed."}))
          return

      else:
        self.response.write(json.dumps({"Statu" : "405","Description" : "Token not vail"}))
           
app = webapp2.WSGIApplication([
    ('/Login', MainPage),
], debug=True)

