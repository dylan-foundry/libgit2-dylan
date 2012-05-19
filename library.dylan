module: dylan-user

define library libgit2
  use common-dylan;
  use c-ffi;

  export libgit2;
end library;

define module libgit2
  use common-dylan;
  use c-ffi;

  export
    git-attr-get,
    git-attr-get-many,
    git-attr-foreach,
    git-attr-cache-flush,
    git-attr-add-macro,
    git-blob-rawcontent,
    git-blob-rawsize,
    git-blob-create-fromfile,
    git-blob-create-fromdisk,
    git-blob-create-frombuffer,
    git-branch-create,
    git-branch-delete,
    git-branch-list,
    git-branch-move,
    git-commit-id,
    git-commit-message-encoding,
    git-commit-message,
    git-commit-time,
    git-commit-time-offset,
    git-commit-committer,
    git-commit-author,
    git-commit-tree,
    git-commit-tree-oid,
    git-commit-parentcount,
    git-commit-parent,
    git-commit-parent-oid,
    git-commit-create,
    git-commit-create-v,
    git-strarray-free,
    git-strarray-copy,
    git-libgit2-version,
    git-config-find-global,
    git-config-find-system,
    git-config-open-global,
    git-config-file--ondisk,
    git-config-new,
    git-config-add-file,
    git-config-add-file-ondisk,
    git-config-open-ondisk,
    git-config-free,
    git-config-get-int32,
    git-config-get-int64,
    git-config-get-bool,
    git-config-get-string,
    git-config-get-multivar,
    git-config-set-int32,
    git-config-set-int64,
    git-config-set-bool,
    git-config-set-string,
    git-config-set-multivar,
    git-config-delete,
    git-config-foreach,
    git-config-get-mapped,
    git-diff-list-free,
    git-diff-tree-to-tree,
    git-diff-index-to-tree,
    git-diff-workdir-to-index,
    git-diff-workdir-to-tree,
    git-diff-merge,
    git-diff-foreach,
    git-diff-print-compact,
    git-diff-print-patch,
    git-diff-blobs,
    giterr-last,
    giterr-clear,
    git-index-open,
    git-index-clear,
    git-index-free,
    git-index-read,
    git-index-write,
    git-index-find,
    git-index-uniq,
    git-index-add,
    git-index-add2,
    git-index-append,
    git-index-append2,
    git-index-remove,
    git-index-get,
    git-index-entrycount,
    git-index-entrycount-unmerged,
    git-index-get-unmerged-bypath,
    git-index-get-unmerged-byindex,
    git-index-entry-stage,
    git-index-read-tree,
    git-indexer-stream-new,
    git-indexer-stream-add,
    git-indexer-stream-finalize,
    git-indexer-stream-hash,
    git-indexer-stream-free,
    git-indexer-new,
    git-indexer-run,
    git-indexer-write,
    git-indexer-hash,
    git-indexer-free,
    git-merge-base,
    git-note-read,
    git-note-message,
    git-note-oid,
    git-note-create,
    git-note-remove,
    git-note-free,
    git-note-default-ref,
    git-note-foreach,
    git-object-lookup,
    git-object-lookup-prefix,
    git-object-id,
    git-object-type,
    git-object-owner,
    git-object-free,
    git-object-type2string,
    git-object-string2type,
    git-object-typeisloose,
    git-object--size,
    git-odb-new,
    git-odb-open,
    git-odb-add-backend,
    git-odb-add-alternate,
    git-odb-free,
    git-odb-read,
    git-odb-read-prefix,
    git-odb-read-header,
    git-odb-exists,
    git-odb-write,
    git-odb-open-wstream,
    git-odb-open-rstream,
    git-odb-hash,
    git-odb-hashfile,
    git-odb-object-free,
    git-odb-object-id,
    git-odb-object-data,
    git-odb-object-size,
    git-odb-object-type,
    git-odb-backend-pack,
    git-odb-backend-loose,
    git-oid-fromstr,
    git-oid-fromstrn,
    git-oid-fromraw,
    git-oid-fmt,
    git-oid-pathfmt,
    git-oid-allocfmt,
    git-oid-tostr,
    git-oid-cpy,
    git-oid-cmp,
    git-oid-ncmp,
    git-oid-streq,
    git-oid-iszero,
    git-oid-shorten-new,
    git-oid-shorten-add,
    git-oid-shorten-free,
    git-reflog-read,
    git-reflog-write,
    git-reflog-rename,
    git-reflog-delete,
    git-reflog-entrycount,
    git-reflog-entry-byindex,
    git-reflog-entry-oidold,
    git-reflog-entry-oidnew,
    git-reflog-entry-committer,
    git-reflog-entry-msg,
    git-reflog-free,
    git-reference-lookup,
    git-reference-name-to-oid,
    git-reference-create-symbolic,
    git-reference-create-oid,
    git-reference-oid,
    git-reference-target,
    git-reference-type,
    git-reference-name,
    git-reference-resolve,
    git-reference-owner,
    git-reference-set-target,
    git-reference-set-oid,
    git-reference-rename,
    git-reference-delete,
    git-reference-packall,
    git-reference-listall,
    git-reference-foreach,
    git-reference-is-packed,
    git-reference-reload,
    git-reference-free,
    git-reference-cmp,
    git-refspec-src,
    git-refspec-dst,
    git-refspec-src-matches,
    git-refspec-transform,
    git-remote-new,
    git-remote-load,
    git-remote-save,
    git-remote-name,
    git-remote-url,
    git-remote-set-fetchspec,
    git-remote-fetchspec,
    git-remote-set-pushspec,
    git-remote-pushspec,
    git-remote-connect,
    git-remote-ls,
    git-remote-download,
    git-remote-connected,
    git-remote-disconnect,
    git-remote-free,
    git-remote-update-tips,
    git-remote-valid-url,
    git-remote-supported-url,
    git-remote-list,
    git-remote-add,
    git-repository-open,
    git-repository-discover,
    git-repository-open-ext,
    git-repository-free,
    git-repository-init,
    git-repository-head,
    git-repository-head-detached,
    git-repository-head-orphan,
    git-repository-is-empty,
    git-repository-path,
    git-repository-workdir,
    git-repository-set-workdir,
    git-repository-is-bare,
    git-repository-config,
    git-repository-set-config,
    git-repository-odb,
    git-repository-set-odb,
    git-repository-index,
    git-repository-set-index,
    git-revwalk-new,
    git-revwalk-reset,
    git-revwalk-push,
    git-revwalk-push-glob,
    git-revwalk-push-head,
    git-revwalk-hide,
    git-revwalk-hide-glob,
    git-revwalk-hide-head,
    git-revwalk-push-ref,
    git-revwalk-hide-ref,
    git-revwalk-next,
    git-revwalk-sorting,
    git-revwalk-free,
    git-revwalk-repository,
    git-signature-new,
    git-signature-now,
    git-signature-dup,
    git-signature-free,
    git-status-foreach,
    git-status-foreach-ext,
    git-status-file,
    git-status-should-ignore,
    git-submodule-foreach,
    git-submodule-lookup,
    git-tag-id,
    git-tag-target,
    git-tag-target-oid,
    git-tag-type,
    git-tag-name,
    git-tag-tagger,
    git-tag-message,
    git-tag-create,
    git-tag-create-frombuffer,
    git-tag-create-lightweight,
    git-tag-delete,
    git-tag-list,
    git-tag-list-match,
    git-tag-peel,
    git-threads-init,
    git-threads-shutdown,
    git-tree-id,
    git-tree-entrycount,
    git-tree-entry-byname,
    git-tree-entry-byindex,
    git-tree-entry-attributes,
    git-tree-entry-name,
    git-tree-entry-id,
    git-tree-entry-type,
    git-tree-entry-2object,
    git-tree-create-fromindex,
    git-treebuilder-create,
    git-treebuilder-clear,
    git-treebuilder-free,
    git-treebuilder-get,
    git-treebuilder-insert,
    git-treebuilder-remove,
    git-treebuilder-filter,
    git-treebuilder-write,
    git-tree-get-subtree,
    git-tree-walk,
    git-tree-diff,
    git-tree-diff-index-recursive;

  export
    $GIT-ATTR-CHECK-FILE-THEN-INDEX,
    $GIT-ATTR-CHECK-INDEX-THEN-FILE,
    $GIT-ATTR-CHECK-INDEX-ONLY,
    $GIT-ATTR-CHECK-NO-SYSTEM,
    $GIT-BRANCH-LOCAL,
    $GIT-BRANCH-REMOTE,
    $GIT-PATH-LIST-SEPARATOR,
    $GIT-PATH-MAX,
    $GIT-CVAR-FALSE,
    $GIT-CVAR-TRUE,
    $GIT-CVAR-INT32,
    $GIT-CVAR-STRING,
    $GIT-DIFF-NORMAL,
    $GIT-DIFF-REVERSE,
    $GIT-DIFF-FORCE-TEXT,
    $GIT-DIFF-IGNORE-WHITESPACE,
    $GIT-DIFF-IGNORE-WHITESPACE-CHANGE,
    $GIT-DIFF-IGNORE-WHITESPACE-EOL,
    $GIT-DIFF-IGNORE-SUBMODULES,
    $GIT-DIFF-PATIENCE,
    $GIT-DIFF-INCLUDE-IGNORED,
    $GIT-DIFF-INCLUDE-UNTRACKED,
    $GIT-DIFF-INCLUDE-UNMODIFIED,
    $GIT-DIFF-RECURSE-UNTRACKED-DIRS,
    $GIT-DIFF-FILE-VALID-OID,
    $GIT-DIFF-FILE-FREE-PATH,
    $GIT-DIFF-FILE-BINARY,
    $GIT-DIFF-FILE-NOT-BINARY,
    $GIT-DIFF-FILE-FREE-DATA,
    $GIT-DIFF-FILE-UNMAP-DATA,
    $GIT-DELTA-UNMODIFIED,
    $GIT-DELTA-ADDED,
    $GIT-DELTA-DELETED,
    $GIT-DELTA-MODIFIED,
    $GIT-DELTA-RENAMED,
    $GIT-DELTA-COPIED,
    $GIT-DELTA-IGNORED,
    $GIT-DELTA-UNTRACKED,
    $GIT-DIFF-LINE-CONTEXT,
    $GIT-DIFF-LINE-ADDITION,
    $GIT-DIFF-LINE-DELETION,
    $GIT-DIFF-LINE-ADD-EOFNL,
    $GIT-DIFF-LINE-DEL-EOFNL,
    $GIT-DIFF-LINE-FILE-HDR,
    $GIT-DIFF-LINE-HUNK-HDR,
    $GIT-DIFF-LINE-BINARY,
    $GIT-SUCCESS,
    $GIT-ERROR,
    $GIT-ENOTFOUND,
    $GIT-EEXISTS,
    $GIT-EOVERFLOW,
    $GIT-EAMBIGUOUS,
    $GIT-EPASSTHROUGH,
    $GIT-ESHORTBUFFER,
    $GIT-EREVWALKOVER,
    $GITERR-NOMEMORY,
    $GITERR-OS,
    $GITERR-INVALID,
    $GITERR-REFERENCE,
    $GITERR-ZLIB,
    $GITERR-REPOSITORY,
    $GITERR-CONFIG,
    $GITERR-REGEX,
    $GITERR-ODB,
    $GITERR-INDEX,
    $GITERR-OBJECT,
    $GITERR-NET,
    $GITERR-TAG,
    $GITERR-TREE,
    $GIT-IDXENTRY-NAMEMASK,
    $GIT-IDXENTRY-STAGEMASK,
    $GIT-IDXENTRY-EXTENDED,
    $GIT-IDXENTRY-VALID,
    $GIT-IDXENTRY-STAGESHIFT,
    $GIT-IDXENTRY-UPDATE,
    $GIT-IDXENTRY-REMOVE,
    $GIT-IDXENTRY-UPTODATE,
    $GIT-IDXENTRY-ADDED,
    $GIT-IDXENTRY-HASHED,
    $GIT-IDXENTRY-UNHASHED,
    $GIT-IDXENTRY-WT-REMOVE,
    $GIT-IDXENTRY-CONFLICTED,
    $GIT-IDXENTRY-UNPACKED,
    $GIT-IDXENTRY-NEW-SKIP-WORKTREE,
    $GIT-IDXENTRY-INTENT-TO-ADD,
    $GIT-IDXENTRY-SKIP-WORKTREE,
    $GIT-IDXENTRY-EXTENDED2,
    $GIT-IDXENTRY-EXTENDED-FLAGS,
    $GIT-DEFAULT-PORT,
    $GIT-DIR-FETCH,
    $GIT-DIR-PUSH,
    $GIT-OBJ-ANY,
    $GIT-OBJ-BAD,
    $GIT-OBJ--EXT1,
    $GIT-OBJ-COMMIT,
    $GIT-OBJ-TREE,
    $GIT-OBJ-BLOB,
    $GIT-OBJ-TAG,
    $GIT-OBJ--EXT2,
    $GIT-OBJ-OFS-DELTA,
    $GIT-OBJ-REF-DELTA,
    $GIT-STREAM-RDONLY,
    $GIT-STREAM-WRONLY,
    $GIT-STREAM-RW,
    $GIT-OID-RAWSZ,
    $GIT-OID-HEXSZ,
    $GIT-OID-MINPREFIXLEN,
    $GIT-REF-INVALID,
    $GIT-REF-OID,
    $GIT-REF-SYMBOLIC,
    $GIT-REF-PACKED,
    $GIT-REF-HAS-PEEL,
    $GIT-REF-LISTALL,
    $GIT-REPOSITORY-OPEN-NO-SEARCH,
    $GIT-REPOSITORY-OPEN-CROSS-FS,
    $GIT-SORT-NONE,
    $GIT-SORT-TOPOLOGICAL,
    $GIT-SORT-TIME,
    $GIT-SORT-REVERSE,
    $GIT-STATUS-SHOW-INDEX-AND-WORKDIR,
    $GIT-STATUS-SHOW-INDEX-ONLY,
    $GIT-STATUS-SHOW-WORKDIR-ONLY,
    $GIT-STATUS-SHOW-INDEX-THEN-WORKDIR,
    $GIT-STATUS-CURRENT,
    $GIT-STATUS-INDEX-NEW,
    $GIT-STATUS-INDEX-MODIFIED,
    $GIT-STATUS-INDEX-DELETED,
    $GIT-STATUS-WT-NEW,
    $GIT-STATUS-WT-MODIFIED,
    $GIT-STATUS-WT-DELETED,
    $GIT-STATUS-IGNORED,
    $GIT-STATUS-OPT-INCLUDE-UNTRACKED,
    $GIT-STATUS-OPT-INCLUDE-IGNORED,
    $GIT-STATUS-OPT-INCLUDE-UNMODIFIED,
    $GIT-STATUS-OPT-EXCLUDE-SUBMODULES,
    $GIT-STATUS-OPT-RECURSE-UNTRACKED-DIRS,
    $GIT-SUBMODULE-UPDATE-CHECKOUT,
    $GIT-SUBMODULE-UPDATE-REBASE,
    $GIT-SUBMODULE-UPDATE-MERGE,
    $GIT-SUBMODULE-IGNORE-ALL,
    $GIT-SUBMODULE-IGNORE-DIRTY,
    $GIT-SUBMODULE-IGNORE-UNTRACKED,
    $GIT-SUBMODULE-IGNORE-NONE,
    $GIT-TREEWALK-PRE,
    $GIT-TREEWALK-POST,
    $GIT-STATUS-ADDED,
    $GIT-STATUS-DELETED,
    $GIT-STATUS-MODIFIED,
    $LIBGIT2-VERSION,
    $LIBGIT2-VER-MAJOR,
    $LIBGIT2-VER-MINOR,
    $LIBGIT2-VER-REVISION;
end module;