// Auto-imported filters by 'gmailctl download'.
//
// WARNING: This functionality is experimental. Before making any
// changes, check that no diff is detected with the remote filters by
// using the 'diff' command.

// Uncomment if you want to use the standard library.
// local lib = import 'gmailctl.libsonnet';

local labels = [
  { name: 'Github' },
];

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
    actions: { category: 'personal' },
  },
  // Keep important notifications in Inbox
  {
    filter: {
      and: [
        { from: 'notifications@github.com' },
        { or: [{ cc: email } for email in githubKeepInInbox] },
      ],
    },
    actions: { category: 'personal' },
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

{
  version: 'v1alpha3',
  labels: labels,
  rules: githubRules,
}
