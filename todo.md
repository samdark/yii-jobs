Yii Jobs TODO
=============

Modularity
----------

Should be implemented as a module in the same way as [Yeeki](https://github.com/samdark/Yeeki).

Minimal functionality
---------------------

### Roles

There are three roles in the system:

- Employer - the one who's posting a job offer.
- Employee - the one who's seeking for the job.
- Admin - the one who's able to manage everything.

### Any user should be able to fill his profile

The following fields are available:

- Name (required).
- Email (required).
- Website.
- Company name.
- Skype.
- Jabber.
- ICQ.

### Employer should be able to add a job

The following fields are to be filled:

- Title.
- Type (fulltime, contract, freelance).
- Text (markdown freeform text).
- Tags (for example, PHP, Yii, API).
- Salary / price range.
- Expiration date (can't be more than 2 months).

### Employer should be able to prolong the offer

At the time offer is about to expire employer should receive an email and be able to
prolong it for 2 months max.

### Employer should be able to close the offer

That's especially useful when employee is found and employer doesn't want to receive more offers.
When closing a job there should be a page asking for a reason. Reasons are:

- Employee found.
- Project cancelled.

### User should be able to filter jobs by any fields available

Search is very important for such a project. Implementation should be made as an adapter,
i.e. default is just SQL DBMS but should be easily replaceable with Sphinx or SOLR.


Additional functionality
------------------------

- i18n. At least for application messages. Default should be English.
- Support of non-MySQL backends.
- Implementation of SOLR / Sphinx adapters.
- Implementation of auth adapters.
