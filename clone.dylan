module: libgit2
synopsis: clone related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define git-options <git-clone-options*>
  option git-clone-options$version => version;
  option git-clone-options$checkout-opts => checkout-options;
  option git-clone-options$remote-callbacks => remote-callbacks;
  option git-clone-options$bare => bare?;
  option git-clone-options$ignore-cert-errors => ignore-cert-errors;
  option git-clone-options$local => local?;
  option git-clone-options$remote-name => remote-name;
  option git-clone-options$checkout-branch => checkout-branch;
  option git-clone-options$signature => signature;
end git-options;

define method git-clone
    (url :: <string>, path :: <string>,
     #key checkout-options = #f,
          remote-callbacks = #f,
          bare? = #f,
          ignore-cert-errors = #f,
          local? = #f,
          remote-name = #f,
          checkout-branch = #f,
          signature = #f)
 => (err, repo)
  let options
    = if (checkout-options | remote-callbacks | bare? | ignore-cert-errors |
          local? | remote-name | checkout-branch | signature)
        make(<git-clone-options*>,
             version: 1,
             checkout-options: checkout-options,
             remote-callbacks: remote-callbacks,
             bare?: bare?,
             ignore-cert-errors: ignore-cert-errors,
             local?: local?,
             remote-name: remote-name,
             checkout-branch: checkout-branch,
             signature: signature)
      else
        null-pointer(<git-clone-options*>)
      end if;
  %git-clone(url, path, options)
end method git-clone;

define method git-clone-into
    (repository :: <git-repository*>, remote :: <git-remote*>,
     #key branch :: false-or(<string>) = #f,
          signature :: <git-signature*> = null-pointer(<git-signature*>),
          checkout-strategy = #f,
          disable-filters = #f,
          dir-mode = #f,
          file-mode = #f,
          file-open-flags = #f,
          notify-flags = #f,
          notify-callback = #f,
          notify-payload = #f,
          progress-callback = #f,
          progress-payload = #f,
          paths = #f,
          baseline = #f,
          target-directory = #f,
          ancestor-label = #f,
          our-label = #f,
          their-label = #f)
 => (err)
  let options
    = if (checkout-strategy | disable-filters | dir-mode | file-mode | file-open-flags |
          notify-flags | notify-callback | notify-payload | progress-callback |
          progress-payload | paths | baseline | target-directory | ancestor-label |
          our-label | their-label)
        make(<git-checkout-options*>,
             version: 1,
             checkout-strategy: checkout-strategy,
             disable-filters: disable-filters,
             dir-mode: dir-mode,
             file-mode: file-mode,
             file-open-flags: file-open-flags,
             notify-flags: notify-flags,
             notify-callback: notify-callback,
             notify-payload: notify-payload,
             progress-callback: progress-callback,
             progress-payload: progress-payload,
             paths: paths,
             baseline: baseline,
             target-directory: target-directory,
             ancestor-label: ancestor-label,
             our-label: our-label,
             their-label: their-label)
      else
        null-pointer(<git-checkout-options*>)
      end if;
  %git-clone-into(repository, remote, options, if (branch) branch else null-pointer(<c-string>) end, signature)
end method git-clone-into;
