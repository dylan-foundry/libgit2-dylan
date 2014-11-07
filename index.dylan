module: libgit2
synopsis: index related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define function git-index-read
    (idx :: <git-index*>, #key force? :: <boolean> = #f)
 => ()
  %git-index-read(idx, if (force?) 1 else 0 end)
end function git-index-read;

define function git-index-write-tree
    (idx :: <git-index*>, #key repository :: false-or(<git-repository*>) = #f)
 => (new-tree-id :: <git-oid*>)
  let oid = make(<git-oid*>);
  if (repository)
    %git-index-write-tree-to(oid, idx, repository)
  else
    %git-index-write-tree(oid, idx)
  end if;
  oid
end function git-index-write-tree;

define function git-index-get-by-path
    (idx :: <git-index*>, path :: <string>, #key stage :: <integer> = 0)
 => (entry :: <git-index-entry*>)
  %git-index-get-by-path(idx, path, stage)
end function git-index-get-by-path;

define function git-index-add-all
    (idx :: <git-index*>, paths :: <sequence>,
     #key flags :: <integer> = 0,
          callback :: false-or(<C-function-pointer>) = #f,
          payload = #f)
 => ()
  let c-paths = sequence-to-strarray(paths);
  %git-index-add-all(idx, c-paths, flags,
                     if (callback) callback else null-pointer(<C-void*>) end,
                     if (payload) payload else null-pointer(<C-void*>) end);
end function git-index-add-all;

define function git-index-remove-all
    (idx :: <git-index*>, paths :: <sequence>,
     #key callback :: false-or(<C-function-pointer>) = #f,
          payload = #f)
 => ()
  let c-paths = sequence-to-strarray(paths);
  %git-index-remove-all(idx, c-paths,
                        if (callback) callback else null-pointer(<C-void*>) end,
                        if (payload) payload else null-pointer(<C-void*>) end);
end function git-index-remove-all;

define function git-index-update-all
    (idx :: <git-index*>, paths :: <sequence>,
     #key callback :: false-or(<C-function-pointer>) = #f,
          payload = #f)
 => ()
  let c-paths = sequence-to-strarray(paths);
  %git-index-update-all(idx, c-paths,
                        if (callback) callback else null-pointer(<C-void*>) end,
                        if (payload) payload else null-pointer(<C-void*>) end);
end function git-index-update-all;
