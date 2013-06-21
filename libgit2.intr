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
          error(make(<libgit2-error>, status: result, message: ""));
        else
          result;
        end;
      end;
end;

define interface
  #include {
    "git2/attr.h",
    "git2/blob.h",
    "git2/branch.h",
    "git2/commit.h",
    "git2/common.h",
    "git2/config.h",
    "git2/diff.h",
    "git2/errors.h",
    "git2/index.h",
    "git2/indexer.h",
    "git2/merge.h",
    "git2/net.h",
    "git2/notes.h",
    "git2/object.h",
    "git2/odb.h",
    "git2/odb_backend.h",
    "git2/oid.h",
    "git2/reflog.h",
    "git2/refs.h",
    "git2/refspec.h",
    "git2/remote.h",
    "git2/repository.h",
    "git2/revwalk.h",
    "git2/signature.h",
    "git2/status.h",
    "git2/submodule.h",
    "git2/tag.h",
    "git2/threads.h",
    "git2/tree.h",
    "git2/types.h",
    "git2/version.h"
    },
    equate: {"char *" => <c-string>},
    exclude: {
      "git_blob_id",
      "git_blob_lookup",
      "git_blob_lookup_prefix",
      "git_blob_free",
      "git_commit_id",
      "git_commit_lookup",
      "git_commit_lookup_prefix",
      "git_commit_free",
      "git_oid_cmp",
      "git_oid_equal",
      "git_tag_lookup",
      "git_tag_lookup_prefix",
      "git_tag_free",
      "git_tree_lookup",
      "git_tree_lookup_prefix",
      "git_tree_free"
    };

  function "git_repository_open",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_open_ext",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_init",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_head",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_config",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_odb",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_index",
    map-result: <libgit2-status>,
    output-argument: 1;
end interface;
