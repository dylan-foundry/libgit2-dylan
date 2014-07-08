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

  function "git_repository_open" => %git-repository-open,
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_open_ext" => %git-repository-open-ext,
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_open_bare",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_init" => %git-repository-init,
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_repository_init_ext" => %git-repository-init-ext,
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_clone" => %git-clone,
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

  function "git_remote_create",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_remote_create_with_fetchspec",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_clone_into" => %git-clone-into,
    map-result: <libgit2-status>;

  function "git_config_set_bool",
    map-argument: { "value" => <C-boolean> },
    map-result: <libgit2-status>;

  // TODO: check other git_config_set functions

  // setting output-argument: 1 would result in an error (No next method)
  // so I'm just renaming it, then defining a wrapper below.
  function "git_oid_fromstr" => %git-oid-from-string,
    map-result: <libgit2-status>;

  function "git_oid_allocfmt" => %git-oid-allocfmt;

  function "git_commit_lookup",
    map-result: <libgit2-status>,
    output-argument: 1;

  function "git_commit_lookup_prefix",
    map-result: <libgit2-status>,
    output-argument: 1;
end interface;

