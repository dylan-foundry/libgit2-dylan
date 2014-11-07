module: libgit2
synopsis: generated bindings for the libgit2 library
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

define class <libgit2-error> (<error>)
  constant slot libgit2-error-status :: <integer>, required-init-keyword: status:;
  constant slot libgit2-error-message :: <string>, init-keyword: message:, init-value: "Unknown error";
end;

define C-mapped-subtype <libgit2-status> (<C-int>)
  import-map <integer>,
    import-function:
      method (result :: <integer>) => (checked :: <integer>)
        if (result < 0)
          let err = giterr-last();
          error(make(<libgit2-error>, status: result, message: git-error$message(err)));
        else
          result;
        end;
      end;
end;

define interface
  #include {
    "git2/attr.h",
    "git2/blame.h",
    "git2/blob.h",
    "git2/branch.h",
    "git2/buffer.h",
    "git2/checkout.h",
    "git2/cherrypick.h",
    "git2/clone.h",
    "git2/commit.h",
    "git2/common.h",
    "git2/config.h",
    "git2/cred_helpers.h",
    "git2/diff.h",
    "git2/errors.h",
    "git2/filter.h",
    "git2/graph.h",
    "git2/ignore.h",
    "git2/indexer.h",
    "git2/index.h",
    "git2/merge.h",
    "git2/message.h",
    "git2/net.h",
    "git2/notes.h",
    "git2/object.h",
    "git2/odb_backend.h",
    "git2/odb.h",
    "git2/oid.h",
    "git2/pack.h",
    "git2/patch.h",
    "git2/pathspec.h",
    "git2/push.h",
    "git2/refdb.h",
    "git2/reflog.h",
    "git2/refs.h",
    "git2/refspec.h",
    "git2/remote.h",
    "git2/repository.h",
    "git2/reset.h",
    "git2/revert.h",
    "git2/revparse.h",
    "git2/revwalk.h",
    "git2/signature.h",
    "git2/stash.h",
    "git2/status.h",
    "git2/strarray.h",
    "git2/submodule.h",
    "git2/sys/commit.h",
    "git2/sys/config.h",
    "git2/sys/diff.h",
    "git2/sys/filter.h",
    "git2/sys/index.h",
    "git2/sys/mempack.h",
    "git2/sys/odb_backend.h",
    "git2/sys/refdb_backend.h",
    "git2/sys/reflog.h",
    "git2/sys/refs.h",
    "git2/sys/repository.h",
    "git2/tag.h",
    "git2/threads.h",
    "git2/trace.h",
    "git2/transport.h",
    "git2/tree.h",
    "git2/types.h",
    "git2/version.h"
    },
    equate: {"char *" => <c-string>};

  pointer "git_status_list *" => <git-status-list*>,
    superclasses: {<sequence>};

  function "git_repository_open" => %git-repository-open,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_open_ext" => %git-repository-open-ext,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_open_bare",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_init" => %git-repository-init,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_init_ext" => %git-repository-init-ext,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_index",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_clone" => %git-clone,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_head",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_config",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_odb",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_index",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_remote_create",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_remote_create_with_fetchspec",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_clone_into" => %git-clone-into,
    map-error-result: <libgit2-status>;

  function "git_config_set_bool",
    map-argument: { "value" => <C-boolean> },
    map-error-result: <libgit2-status>;

  // TODO: check other git_config_set functions

  // setting output-argument: 1 would result in an error (No next method)
  // so I'm just renaming it, then defining a wrapper below.
  function "git_oid_fromstr" => %git-oid-from-string,
    map-error-result: <libgit2-status>;

  function "git_oid_allocfmt" => %git-oid-allocfmt;

  function "git_commit_create" => %git-commit-create,
    map-error-result: <libgit2-status>;

  function "git_commit_lookup",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_commit_lookup_prefix",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_commit_parentcount" => git-commit-parent-count;

  function "git_commit_parent",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_commit_nth_gen_ancestor",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_blob_lookup",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_blob_lookup_prefix",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_blob_filtered_content" => %git-blob-filtered-content,
    map-error-result: <libgit2-status>;

  function "git_blob_create_fromworkdir" => %git-blob-create-fromworkdir,
    map-error-result: <libgit2-status>;

  function "git_blob_create_fromdisk" => %git-blob-create-fromdisk,
    map-error-result: <libgit2-status>;

  function "git_blob_create_frombuffer" => %git-blob-create-frombuffer,
    map-error-result: <libgit2-status>;

  function "git_commit_tree",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_diff_foreach" => %git-diff-foreach,
    map-error-result: <libgit2-status>;

  function "git_diff_index_to_workdir" => %git-diff-index-to-working-directory,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_patch_from_diff",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_diff_tree_to_index" => %git-diff-tree-to-index,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_diff_tree_to_workdir_with_index" => %git-diff-tree-to-working-directory-with-index,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_diff_tree_to_tree" => %git-diff-tree-to-tree,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_index_add_bypath" => git-index-add-by-path;

  function "git_index_add_all" => %git-index-add-all,
    map-error-result: <libgit2-status>;

  function "git_index_remove_all" => %git-index-remove-all,
    map-error-result: <libgit2-status>;

  function "git_index_update_all" => %git-index-update-all,
    map-error-result: <libgit2-status>;

  function "git_index_remove_bypath" => git-index-remove-by-path;

  function "git_index_entrycount" => git-index-entry-count;

  function "git_index_get_byindex" => git-index-get-by-index;

  function "git_index_get_bypath" => %git-index-get-by-path;

  function "git_index_new",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_index_open",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_index_read" => %git-index-read,
    map-error-result: <libgit2-status>;

  function "git_index_write_tree" => %git-index-write-tree,
    map-error-result: <libgit2-status>;

  function "git_index_write_tree_to" => %git-index-write-tree-to,
    map-error-result: <libgit2-status>;

  function "git_tree_lookup",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_tree_entry_byindex" => git-tree-entry-by-index;
  function "git_tree_entry_byid" => git-tree-entry-by-id;
  function "git_tree_entry_byname" => git-tree-entry-by-name;
  function "git_tree_entry_bypath" => git-tree-entry-by-path,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_revparse_single",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_treebuilder_create" => %git-treebuilder-create,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_treebuilder_insert",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_treebuilder_write" => %git-treebuilder-write,
    map-error-result: <libgit2-status>;

  function "git_signature_now",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_reference_create" => %git-reference-create,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_reference_symbolic_create" => %git-reference-symbolic-create,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_reference_dwim",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_reference_list" => %git-reference-list,
    map-error-result: <libgit2-status>;

  function "git_reference_lookup",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_reference_name_to_id" => %git-reference-name-to-id,
    map-error-result: <libgit2-status>;

  function "git_status_byindex" => git-status-by-index;

  function "git_status_list_new" => git-status-list,
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_tag_create" => %git-tag-create,
    map-error-result: <libgit2-status>;

  function "git_tag_create_lightweight" => %git-tag-create-lightweight,
    map-error-result: <libgit2-status>;

  function "git_tag_lookup",
    map-error-result: <libgit2-status>,
    output-argument: 1;

  function "git_tag_list" => %git-tag-list,
    map-error-result: <libgit2-status>;

  function "git_tag_list_match" => %git-tag-list-match,
    map-error-result: <libgit2-status>;
end interface;

