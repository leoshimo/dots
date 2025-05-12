// Docs: https://github.com/mbrt/gmailctl
// local lib = import 'gmailctl.libsonnet';

local feedbinEmail = 'gmailforwarded.115@feedb.in';

local labels = [
  { name: 'Github' },
];

// # Github

// CC emails mark notification type
// https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications
local githubKeepInInbox = [
  'manual@noreply.github.com',
  'assign@noreply.github.com',
  'author@noreply.github.com',
  'mention@noreply.github.com',
  'review_requested@noreply.github.com',
];
local githubSkipFeedbin = [
  'push@noreply.github.com',
];

// Github rules
local githubRules = [
  // Label + Forward all GH notifications
  {
    filter: {
      and: [
        { from: 'notifications@github.com' },
        { not: { or: [{ cc: email } for email in githubSkipFeedbin] } },
      ]
    },
    actions: {
      labels: ['Github'],
      forward: 'github-forwarded.537@feedb.in',
    },
  },
  // Keep manual subscriptions in Inbox
  {
    filter: {
      and: [
        { from: 'notifications@github.com' },
        { cc: 'manual@noreply.github.com' },
      ],
    },
    actions: { category: 'forums' },
  },
  // Keep important notifications in Inbox
  {
    filter: {
      and: [
        { from: 'notifications@github.com' },
        { or: [{ cc: email } for email in githubKeepInInbox] },
      ],
    },
    actions: { category: 'forums' },
  },
  // Delete remaining auto subscriptions
  {
    filter: {
      and: [
        { from: 'notifications@github.com' },
        { not: { or: [{ cc: email } for email in githubKeepInInbox] } },
      ],
    },
    actions: {
      markRead: true,
      delete: true,
    },
  },
];

// # Newsletters

local pulseMCPRules = [{
    filter: {
      from: 'pulsemcp.com'     
    },
    actions: {
      forward: feedbinEmail
    }
}];

// # Auto-Archive

local archiveEmails = [
  // Receipts
  'noreply@uber.com'
];

local archiveRules = [{
    filter: { or: [{ from: email } for email in archiveEmails] },
    actions: {
      archive: true
    }
}];


{
  version: 'v1alpha3',
  labels: labels,
  rules: githubRules + pulseMCPRules + archiveRules,
}
