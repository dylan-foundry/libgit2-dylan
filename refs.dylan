module: libgit2
synopsis: refs related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define function git-reference-name-to-id
    (repo :: <git-repository*>, name :: <string>)
 => (oid :: <git-oid*>)
  let oid = make(<git-oid*>);
  %git-reference-name-to-id(oid, repo, name);
  oid
end function git-reference-name-to-id;

define function git-reference-list
    (repo :: <git-repository*>)
 => (refs :: false-or(<sequence>))
  let c-refs = make(<git-strarray*>);
  %git-reference-list(c-refs, repo);
  strarray-to-vector(c-refs)
end function git-reference-list;

define method git-reference-create
    (repo :: <git-repository*>, name :: <string>, oid :: <git-oid*>,
     #key force? :: <boolean> = #f,
          signature :: false-or(<git-signature*>) = #f,
          log-message :: false-or(<string>) = #f)
 => (ref :: <git-reference*>)
  %git-reference-create(repo,
                        name,
                        oid,
                        if (force?) 1 else 0 end,
                        if (signature) signature else null-pointer(<git-signature*>) end,
                        if (log-message) log-message else null-pointer(<C-string>) end)
end method git-reference-create;

define method git-reference-create
    (repo :: <git-repository*>, name :: <string>, target :: <string>,
     #key force? :: <boolean> = #f,
          signature :: false-or(<git-signature*>) = #f,
          log-message :: false-or(<string>) = #f)
 => (ref :: <git-reference*>)
  %git-reference-symbolic-create(repo,
                                 name,
                                 target,
                                 if (force?) 1 else 0 end,
                                 if (signature) signature else null-pointer(<git-signature*>) end,
                                 if (log-message) log-message else null-pointer(<C-string>) end)
end method git-reference-create;
