module: libgit2
synopsis: checkout related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define git-options <git-checkout-options*>
  option git-checkout-options$version => version;
  option git-checkout-options$checkout-strategy => checkout-strategy;
  option git-checkout-options$disable-filters => disable-filters;
  option git-checkout-options$dir-mode => dir-mode; // TODO: better name
  option git-checkout-options$file-mode => file-mode;
  option git-checkout-options$file-open-flags => file-open-flags;
  option git-checkout-options$notify-flags => notify-flags;
  option git-checkout-options$notify-cb => notify-callback;
  option git-checkout-options$notify-payload => notify-payload;
  option git-checkout-options$progress-cb => progress-callback;
  option git-checkout-options$progress-payload => progress-payload;
  option git-checkout-options$paths => paths;
  option git-checkout-options$baseline => baseline;
  option git-checkout-options$target-directory => target-directory;
  option git-checkout-options$ancestor-label => ancestor-label;
  option git-checkout-options$our-label => our-label;
  option git-checkout-options$their-label => their-label;
end git-options;

