# Oregon Invasives Species Hotline

This project allows members of the public to submit reports of invasive species for experts to review. Experts can login and review the reports, comment on them, and make a final determination about the species that was reported

# To Install

    make init

You can login with an email of "foobar@example.com" with a password of "foobar"

# Tech Used

- Django
- Postgres
- Elasticsearch
- Google Maps
- Imagemagick (to make thumbnails and to convert SVGs to PNGs)

# Notable Hackiness

I **hate** the Sites framework, but we use it (only) so we can use flatpages. To avoid having to update the stupid domain column all the time, I override the Site.objects attribute in utils.py so it returns whatever domain is currently being used.

There is a feature to "subscribe to search". This allows an active user of the system to perform a search on the reports-list page, and then subscribe to it. Meaning whenever a new report is submitted that matches that search, the subscriber will get an email notification about it. The way it is implemented is the request.GET parameters are saved to the UserNotificationQuery model as a string like "querystring=foobar&category-4=142". When a report is submitted, a new ReportSearchForm is instantiated, and passed the decoded GET parameters that were saved in the UserNotificationQuery model. The search() method on the form is called, and if the results contains that newly submitted report, the user gets an email. This is an expensive process, so **it runs in a separate thread**.
