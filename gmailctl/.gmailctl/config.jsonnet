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

// Github rules
local githubRules = [
  // Label + Forward all GH notifications
  {
    filter: { from: 'notifications@github.com' },
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
  // Delete auto subscriptions
  {
    filter: {
      and: [
        { from: 'notifications@github.com' },
        { not: { cc: 'manual@noreply.github.com' } },
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
