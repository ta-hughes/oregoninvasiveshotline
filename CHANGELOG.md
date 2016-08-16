# Change log for Oregon Invasives Hotline

## 1.11.0 - unreleased

In progress...


## 1.10.0 - 2016-08-16

- Change default visibility of comments to protected (only allow
  reporter and commenter to view).
- Constrain  Django Haystack version.

## 1.9.0 - 2016-05-23

### Added

- Quick nav on all admin pages (nav pills at top of page). This is much
  nicer than making admins return to the Admin home page to get to
  another admin page.
- List, edit, and delete views of search subscriptions for admins.
- First & last page pagination controls.
- Additional help text on report form; in particular, which parts of the
  form will be public & private.
- Google Analytics.

### Changed

- Switched to standard Bootstrap pagination controls instead of custom
  markup.

### Fixed

- Moved admin panel out of `species` app.
- Corrected a regression in `Invite.create()` introduced in a6d2022 due
  to incorrect use of `Invite.objects.get_or_create()`. Fixed related
  tests too.

### Miscellaneous

- Clean up various bits of project config.
- Upgraded Python dependencies.

## 1.8.1 - 2016-03-14

### Fixed

- Make page edit form render for "hidden" pages.
