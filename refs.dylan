module: libgit2
synopsis: refs related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define function git-reference-name-to-id
    (repo :: <git-repository*>, name :: <string>)
 => (err, oid :: <git-oid*>)
  let oid = make(<git-oid*>);
  let err = %git-reference-name-to-id(oid, repo, name);
  values(err, oid)
end function git-reference-name-to-id;
