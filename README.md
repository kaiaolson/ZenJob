# ZenJobs

ZenJobs is a content submission application designed for freelancers, consultants,
or contractors to simplify the process of getting information from clients.

## Basic Features

- User Authentication
- Admin Dashboard
- Custom Form Generation: the form that the client sees is based on the category
  of the request (e.g. "file" displays a form with only a file upload field, and "text"
  displays a WYSIWYG text editor field)
- In-app Messaging System (with notification emails)
- Mailers (email notifcations when consultant has submitted a request for information,
  and when client has created a submission)
- Active/Archived Clients
- AWS S3 for file storage
- Teams for companies with multiple consultants
- Background jobs for mailers
- RSpec testing for user creation and login

## Upcoming Features

- Dropbox integration
- Encrypted password field for obtaining login information from clients
- Ability to search requests and submissions
- Twitter/Facebook/Google+ OAuth
- Full RSpec/Capybara testing
