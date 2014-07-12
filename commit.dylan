module: libgit2
synopsis: commit related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define function git-commit-create
    (repo :: <git-repository*>, update-ref :: <string>, author :: <git-signature*>,
     committer :: <git-signature*>, message-encoding :: <string>, message :: <string>,
     tree :: <git-tree*>, parents :: <sequence>)
 => (err, oid :: <git-oid*>)
  let c-parents = make(<git-commit**>, size: size(parents));
  for (p in parents, i from 0)
    c-parents[i] := parents[i];
  end for;
  let oid = make(<git-oid*>);
  let err = %git-commit-create(oid, repo, update-ref, author, committer, message-encoding, message, tree, size(parents), c-parents);
  values(err, oid)
end function git-commit-create;
