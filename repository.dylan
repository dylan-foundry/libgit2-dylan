module: libgit2
synopsis: repository related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define git-options <git-repository-init-options*>
  option git-repository-init-options$version => version = 1;
  option git-repository-init-options$flags => flags;
  option git-repository-init-options$mode => mode;
  option git-repository-init-options$workdir-path => working-directory;
  option git-repository-init-options$description => description;
  option git-repository-init-options$template-path => template-path;
  option git-repository-init-options$initial-head => initial-head;
  option git-repository-init-options$origin-url => origin-url;
end git-options;

define method git-repository-init
    (path :: <string>,
     #key bare? :: <boolean> = #f,
          flags :: false-or(<integer>) = #f,
          mode :: false-or(<integer>) = #f,
          working-directory :: false-or(<string>) = #f,
          description :: false-or(<string>) = #f,
          template-path :: false-or(<string>) = #f,
          initial-head :: false-or(<string>) = #f,
          origin-url :: false-or(<string>) = #f)
 => (repo :: <git-repository*>)
  if (flags | mode | working-directory | description | template-path | initial-head | origin-url)
    let opts = make(<git-repository-init-options*>,
                    flags: flags,
                    mode: mode,
                    working-directory: working-directory,
                    description: description,
                    template-path: template-path,
                    initial-head: initial-head,
                    origin-url: origin-url);
    // TODO: fix this
    //%git-repository-init-ext(path, opts)
    make(<git-repository*>)
  else
    %git-repository-init(path, if (bare?) 1 else 0 end)
  end if
end method git-repository-init;

define method git-repository-open
    (path :: <string>,
     #key flags :: false-or(<integer>) = #f,
     ceiling-directories :: false-or(<string>) = #f)
 => (repo :: <git-repository*>)
  if (flags | ceiling-directories)
    %git-repository-open-ext(path,
                             if (flags) flags else 0 end,
                             if (ceiling-directories) ceiling-directories else null-pointer(<C-string>) end)
  else
    %git-repository-open(path)
  end if
end method git-repository-open;

