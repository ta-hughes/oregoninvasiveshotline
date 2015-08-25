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

I **hate** the Sites framework, but we use it (only) so we can use flatpages. To
avoid having to update the stupid domain column all the time, I override the
Site.objects attribute in utils.py so it returns whatever domain is currently
being used.
