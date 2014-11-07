module: libgit2
synopsis: tags related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define function git-tag-create-lightweight
    (repo :: <git-repository*>, tag-name :: <string>, target :: <git-object*>,
     #key force? :: <boolean> = #f)
 => (tag :: <git-oid*>)
  let oid = make(<git-oid*>);
  %git-tag-create-lightweight(oid, repo, tag-name, target, if (force?) 1 else 0 end);
  oid
end function git-tag-create-lightweight;

define function git-tag-create
    (repo :: <git-repository*>, tag-name :: <string>, target :: <git-object*>,
     tagger :: <git-signature*>, message :: <string>, #key force? :: <boolean> = #f)
 => (tag :: <git-oid*>)
  let oid = make(<git-oid*>);
  %git-tag-create(oid, repo, tag-name, target, tagger, message, if (force?) 1 else 0 end);
  oid
end function git-tag-create;

define function git-tag-list
    (repo :: <git-repository*>, #key pattern :: false-or(<string>) = #f)
 => (tags :: false-or(<sequence>))
  let c-tags = make(<git-strarray*>);
  if (pattern)
    %git-tag-list-match(c-tags, pattern, repo);
  else
    %git-tag-list(c-tags, repo);
  end;
  strarray-to-vector(c-tags)
end function git-tag-list;
