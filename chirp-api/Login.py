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
        out = db.GqlQuery('SELECT * FROM Member WHERE id = :1',id).get()
        if out == None:
          self.response.write(json.dumps({"Statu" : "403","Description" : "ID not registed."}))
          return
        import random 
        import string
        access = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(50))
        out.access_token = access
        out.put()
        self.response.write(json.dumps({"Statu" : "200","Description" : "OK.","access_token" : access}))

      else:
        self.response.write(json.dumps({"Statu" : "405","Description" : "Token not vail"}))
           
app = webapp2.WSGIApplication([
    ('/Login', MainPage),
], debug=True)


class Member(db.Model):
  access_token = db.StringProperty()