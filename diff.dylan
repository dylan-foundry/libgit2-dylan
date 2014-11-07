module: libgit2
synopsis: diff related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define git-options <git-diff-find-options*>
  option git-diff-find-options$version => version = 1;
  option git-diff-find-options$flags => flags;
  option git-diff-find-options$rename-threshold => rename-threshold;
  option git-diff-find-options$rename-from-rewrite-threshold => rename-from-rewrite-threshold;
  option git-diff-find-options$copy-threshold => copy-threshold;
  option git-diff-find-options$break-rewrite-threshold => break-rewrite-threshold;
  option git-diff-find-options$rename-limit => rename-limit;
  option git-diff-find-options$metric => metric;
end git-options;

define method git-diff-index-to-working-directory
    (repo :: <git-repository*>,
     #key index :: false-or(<git-index*>),
          opts :: false-or(<git-diff-options*>))
 => (diff :: <git-diff*>)
  %git-diff-index-to-working-directory
    (repo,
     if (index) index else null-pointer(<git-index*>) end,
     if (opts) opts else null-pointer(<git-diff-options*>) end)
end method git-diff-index-to-working-directory;

define method git-diff-tree-to-index
    (repo :: <git-repository*>,
     tree :: <git-tree*>,
     #key index :: false-or(<git-index*>),
          opts :: false-or(<git-diff-options*>))
 => (diff :: <git-diff*>)
  %git-diff-tree-to-index
    (repo, tree,
     if (index) index else null-pointer(<git-index*>) end,
     if (opts) opts else null-pointer(<git-diff-options*>) end)
end method git-diff-tree-to-index;

define method git-diff-tree-to-working-directory-with-index
    (repo :: <git-repository*>,
     tree :: <git-tree*>,
     #key opts :: false-or(<git-diff-options*>))
 => (diff :: <git-diff*>)
  %git-diff-tree-to-working-directory-with-index
    (repo, tree,
     if (opts) opts else null-pointer(<git-diff-options*>) end)
end method git-diff-tree-to-working-directory-with-index;

define method git-diff-tree-to-tree
    (repo :: <git-repository*>,
     old-tree :: <git-tree*>,
     new-tree :: <git-tree*>,
     #key opts :: false-or(<git-diff-options*>))
 => (diff :: <git-diff*>)
  %git-diff-tree-to-tree
     (repo, old-tree, new-tree,
     if (opts) opts else null-pointer(<git-diff-options*>) end)
end method git-diff-tree-to-tree;

define method git-diff-foreach
    (diff :: <git-diff*>, file-cb :: <C-function-pointer>,
     #key hunk-callback :: false-or(<C-function-pointer>) = #f,
          line-callback :: false-or(<C-function-pointer>) = #f,
          payload = #f)
 => ()
  %git-diff-foreach(diff, file-cb,
                    if (hunk-callback) hunk-callback else null-pointer(<C-void*>) end,
                    if (line-callback) line-callback else null-pointer(<C-void*>) end,
                    if (payload) payload else null-pointer(<C-void*>) end)
end method git-diff-foreach;
