module: libgit2
synopsis: tree related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define method size (tree :: <git-tree*>) => (size :: <integer>)
  git-tree-entrycount(tree)
end method size;

define function git-treebuilder-create
    (#key source :: false-or(<git-tree*>) = #f)
 => (err, treebuilder :: <git-treebuilder*>)
  %git-treebuilder-create(if (source) source else null-pointer(<git-tree*>) end)
end function git-treebuilder-create;

define function git-treebuilder-write
    (repo :: <git-repository*>, bld :: <git-treebuilder*>)
 => (err, oid :: <git-oid*>)
  let oid = make(<git-oid*>);
  let err = %git-treebuilder-write(oid, repo, bld);
  values(err, oid)
end function git-treebuilder-write;
