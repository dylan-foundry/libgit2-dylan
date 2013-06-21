module: libgit2
synopsis: generated bindings for the libgit2 library
author: Bruce Mitchener, Jr.
copyright: See LICENSE file in this distribution.

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
    output-argument: 1;

  function "git_repository_open_ext",
    output-argument: 1;

  function "git_repository_init",
    output-argument: 1;

  function "git_repository_head",
    output-argument: 1;

  function "git_repository_config",
    output-argument: 1;

  function "git_repository_odb",
    output-argument: 1;

  function "git_repository_index",
    output-argument: 1;
end interface;
