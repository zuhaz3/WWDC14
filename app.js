var express = require('express')
  , util = require('util')
  , request = require('request')
  , fs = require('fs')
  , exec = require('child_process').exec;;


var app = express();

// configure Express
app.configure(function() {
  app.set('views', __dirname + '/views');
  app.set('view engine', 'ejs');
  app.use(express.logger());
  app.use(express.cookieParser());
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.session({ secret: 'keyboard cat' }));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.get('/', function(req, res) {
  res.render('index');
});

app.get('/ytfind', function(req, res) {
  res.render('ytfind');
});

app.post('/compile', function(req, res) {
  console.log("got post request");
  var lang = req.body.language;
  var code = req.body.code;
  if(lang.toLowerCase() == 'java') {
    fs.writeFile(__dirname+'/Code.java', code, function(err) {
      if(err)
        console.log(err);
      else {
        console.log("Code.java saved succesfully");
        exec('javac Code.java && java Code', function(err, out, stderr) {
          console.log(out);
          var arr = [];
          arr.push(out);
          res.json(arr);
        });
      }
    });
  }
  else if(lang.toLowerCase() == 'python') {
    fs.writeFile(__dirname+'/code.py', code, function(err) {
      if(err)
        console.log(err);
      else {
        console.log("code.py saved succesfully");
        exec('python code.py', function(err, out, stderr) {
          console.log(out);
          var arr = [];
          arr.push(out);
          res.json(arr);
        });
      }
    });
  }
  else if(lang.toLowerCase() == 'javascript') {
    fs.writeFile(__dirname+'/code.js', code, function(err) {
      if(err)
        console.log(err);
      else {
        console.log("code.js saved succesfully");
        exec('node code.js', function(err, out, stderr) {
          console.log(out);
          var arr = [];
          arr.push(out);
          res.json(arr);
        });
      }
    });
  }
});

app.post('/sendResumeEmail', function(req, res) {
  setTimeout(function() { 
    var path           = require('path')
      , templatesDir   = path.resolve(__dirname, 'templates')
      , emailTemplates = require('email-templates')
      , nodemailer     = require('nodemailer');

    fs.readFile("./zuhayeer-musa-resume-2014.pdf", function (err, data) {
      emailTemplates(templatesDir, function(err, template) {

        if (err) {
          console.log(err);
        } else {

          // Prepare nodemailer transport object
          var transport = nodemailer.createTransport("SMTP", {
            service: "Gmail",
            auth: {
              user: "hi@zmusa.me",
              pass: process.env['EMAIL_SMTP_PASSWORD']
            }
          });

          // An example users object with formatted email function
          var locals = {
            email: req.body.email
          };

          // Send a single email
          template('welcome', locals, function(err, html, text) {
            if (err) {
              console.log(err);
            } else {
              transport.sendMail({
                from: 'Zuhayeer Musa <hi@zmusa.me>',
                to: locals.email,
                subject: 'Zuhayeer Musa\'s Résumé' ,
                html: html,
                text: text,
                attachments : [
                                { 
                                    fileName: "zuhayeer-musa-resume-2014.pdf",
                                    contents: data
                                }
                              ]
              }, function(err, responseStatus) {
                if (err) {
                  console.log(err);
                } else {
                  console.log(responseStatus.message);
                }
              });
            }
          });

        }

      });
    }); 
  }, parseInt(req.body.time.charAt(0)) * 60 * 1000);
  res.json({ "message": "Success" });
});

app.listen(process.env.PORT || 3000);
