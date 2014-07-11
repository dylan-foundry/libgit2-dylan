module: libgit2-test-suite
synopsis: Test suite for the libgit2 library.

define constant $repository-url = "git://github.com/github/testrepo.git";

define function default-repository-and-oid
    () => (repo :: <git-repository*>, oid :: <git-oid*>)
  let sha = "78cf42b3249a69c0602b8bcb074cb6a61156787f";
  let (err1, oid) = git-oid-from-string(sha);
  check-equal("commit found", err1, 0);

  let (err2, repo) = git-repository-open("./temp_testrepo");
  check-equal("repo opened", err2, 0);
  values(repo, oid)
end function default-repository-and-oid;

// Most tests taken from http://libgit2.github.com/docs/guides/101-samples/
define test init-simple-test ()
  // with working directory...
  let (err1, repo) = git-repository-init("./temp_repo");
  check-equal("git-repository-init did not error", err1, 0);

  // ...or bare:
  let (err2, repo) = git-repository-init("./temp_repo2.git", bare?: #t);
  check-equal("git-repository-init did not error", err2, 0);

  check-condition("git-repository-open errors when no repo",
                  <libgit2-error>,
                  git-repository-open("./temp_no_repo"));
end test;

define test init-options-test ()
  let (err, repo) = git-repository-init("./temp_repo_init_options",
                                        flags: $GIT-REPOSITORY-INIT-MKDIR,
                                        description: "My repository has a custom description.",
                                        origin-url: "http://example.org/");
  check-equal("git-repository-init-ext did not error", err, 0);
end test;

define test clone-simple-test ()
  let (err, repo) = git-clone($repository-url, "./temp_testrepo");
  check-equal("git-clone did not error", err, 0);
end test;

define test clone-progress-test ()
  // TODO: implement me
end test;

define test clone-repo-test ()
  let (_, repo) = git-repository-init("./temp_repo_test");
  let (err1, origin) = git-remote-create(repo, "origin", $repository-url);
  check-equal("git-remote-create did not error", err1, 0);

  // customize the remote, set callbacks etc.

  let err2 = git-clone-into(repo, origin, branch: "master");
  check-equal("git-clone-into did not error", err2, 0);
end test;

define test clone-mirror-test ()
  let (_, repo) = git-repository-init("./temp_clone_mirror", bare?: #t);

  // create an 'origin' remote with the mirror fetch refspec
  let (err1, origin) = git-remote-create-with-fetchspec(repo, "origin",
                                                        $repository-url,
                                                        "+refs/*:refs/*");
  check-equal("git-remote-create-with-fetchspec did not error", err1, 0);

  let (err2, cfg) = git-repository-config(repo);
  check-equal("git-repository-config did not error", err2, 0);

  let err3 = git-config-set-bool(cfg, "remote.origin.mirror", #t);
  check-equal("git-config-set-bool did not error", err3, 0);

  let err4 = git-clone-into(repo, origin);
  check-equal("git-clone-into did not error", err4, 0);
end test;

define test open-simple-test ()
  // open repository from clone-simple-test
  let (err, repo) = git-repository-open("./temp_testrepo");
  check-equal("git-repository-open did not error", err, 0);
end test;

define test open-options-test ()
  // open repository, walking up from given directory to find root
  let (err1, _) = git-repository-open("./temp_testrepo/test", flags: 0);
  check-equal("git-repository-open(path) did not error", err1, 0);

  // open repository in given directory (or fail if not a repository)
  // this call should fail
  check-condition("git-repository-open(path, flags) error",
                  <libgit2-error>,
                  git-repository-open("./temp_testrepo/test",
                                      flags: $GIT-REPOSITORY-OPEN-NO-SEARCH));

  // open repository with "ceiling" directories list to limit walking up
  let (err3, _) = git-repository-open("./temp_testrepo/test",
                                      flags: $GIT-REPOSITORY-OPEN-CROSS-FS,
                                      ceiling-directories: "/tmp:./");
  check-equal("git-repository-open(path, flags, ceiling-directories) did not error", err3, 0);
end test;

define test open-bare-test ()
  let (err, _) = git-repository-open-bare("./temp_repo2.git");
  check-equal("git-repository-open-bare did not error", err, 0);
end test;

define test find-repository-test ()
  // TODO: implement me
end test;

define test check-if-repository-test ()
  // TODO: implement me
end test;

define suite libgit2-repositories-test-suite ()
  test init-simple-test;
  test init-options-test;

  test clone-simple-test;
  test clone-progress-test;
  test clone-repo-test;
  test clone-mirror-test;

  test open-simple-test;
  test open-options-test;
  test open-bare-test;

  test find-repository-test;
  test check-if-repository-test;

end suite;

define test SHAs-and-OIDs-test ()
  let sha = "4a202b346bb0fb0db7eff3cffeb3c70babbd2045";
  let (err, oid) = git-oid-from-string(sha);
  check-equal("git-oid-from-string did not error", err, 0);

  let newsha = git-oid-to-string(oid);
  assert-equal(sha, newsha);
end test;

define test lookups-test ()
  let (repo, oid) = default-repository-and-oid();

  let (err3, commit) = git-commit-lookup(repo, oid);
  check-equal("git-commit-lookup did not error", err3, 0);

  git-commit-free(commit);
end test;

define suite libgit2-objects-test-suite ()
  test SHAs-and-OIDs-test;
  test lookups-test;
end suite;

define test blobs-content-test ()
  // ./temp_testrepo/test/alias.c
  let sha = "6c8775cb01546b6855a15f07aae660585d48b491";
  let (err1, oid) = git-oid-from-string(sha);
  check-equal("commit found", err1, 0);

  let (err2, repo) = git-repository-open("./temp_testrepo");
  check-equal("repo opened", err2, 0);

  let (err3, blob) = git-blob-lookup(repo, oid);
  check-equal("git-blob-lookup did not error", err3, 0);

  let raw-size = git-blob-rawsize(blob);
  
  let raw-content = git-blob-rawcontent(blob);
  check-false("git-blob-rawcontent did return something", null-pointer?(raw-content));

  let (err4, filtered-content) = git-blob-filtered-content(blob, "test/alias.c", #t);
end test;

define test blobs-create-test ()
  let (_, repo) = git-repository-open("./temp_testrepo");

  let (err1, _) = git-blob-create-from-working-directory(repo, "test/alias.c");
  check-equal("git-blob-create-from-working-directory did not error", err1, 0);

  let (err2, _) = git-blob-create-from-disk(repo, "/etc/hosts");
  check-equal("git-blob-create-from-disk did not error", err2, 0);

  let (err3, _) = git-blob-create-from-buffer(repo, "Hello there!");
  check-equal("git-blob-create-from-buffer did not error", err3, 0);
end test;

define suite libgit2-blobs-test-suite ()
  test blobs-content-test;
  test blobs-create-test;
end suite;

define test trees-lookups-test ()
  let (repo, oid) = default-repository-and-oid();
  let (err1, commit) = git-commit-lookup(repo, oid);
  check-equal("git-commit-lookup did not error", err1, 0);

  let (err2, _) = git-commit-tree(commit);
  check-equal("git-commit-tree did not error", err2, 0);

  git-commit-free(commit);

  let tree-sha = "cac308be17ad33f3a5bcb2ef2e5eb34f4e28100c";
  let (_, tree-oid) = git-oid-from-string(tree-sha);

  let (err3, tree) = git-tree-lookup(repo, tree-oid);
  check-equal("git-tree-lookup did not error", err3, 0);

  let entry = git-tree-entry-by-index(tree, 0);
  if (git-tree-entry-type(entry) == $GIT-OBJ-TREE)
    let (err4, subtree) = git-tree-lookup(tree, git-tree-entry-id(entry));
    check-equal("git-tree-lookup and git-tree-entry-id did not error", err4, 0);
  end if;
end test;

define test trees-tree-entries-test ()
  let repo = default-repository-and-oid();

  let (err1, obj) = git-revparse-single(repo, "HEAD^{tree}");
  check-equal("git-revparse-single did not error", err1, 0);

  let tree = pointer-cast(<git-tree*>, obj);
  assert-true(size(tree) > 0);

  let entry = git-tree-entry-by-index(tree, 0);
  let name = git-tree-entry-name(entry); // file name
  assert-false(null-pointer?(name));
  let object-type = git-tree-entry-type(entry); // blob or tree
  let mode = git-tree-entry-filemode(entry); // NIX filemode

  let (err2, entry2) = git-tree-entry-by-path(tree, "test/alloc.c");
  check-equal("git-tree-entry-by-path did not error", err2, 0);
  git-tree-entry-free(entry2); // caller has to free this one
end test;

define test trees-walking-test ()
  // TODO: implement me
end test;

define test trees-treebuilder-test ()
  let (_, bld) = git-treebuilder-create();

  // add some entries
  let repo = default-repository-and-oid();
  let (err1, obj) = git-revparse-single(repo, "HEAD:test/alloc.c");
  check-equal("git-revparse-single did not error", err1, 0);

  let (err2, _) = git-treebuilder-insert(bld,
                                         "alloc.c", // filename
                                         git-object-id(obj), // OID
                                         #o100644); // mode
  check-equal("git-treebuilder-insert did not error", err2, 0);
  git-object-free(obj);

  let (_, obj) = git-revparse-single(repo, "HEAD:test/alias.c");
  git-treebuilder-insert(bld,
                         "alias.c",
                         git-object-id(obj),
                         #o100644);
  git-object-free(obj);

  let (err3, tree-oid) = git-treebuilder-write(repo, bld);
  check-equal("git-treebuilder-write did not error", err3, 0);
  git-treebuilder-free(bld);
end test;

define suite libgit2-trees-test-suite ()
  test trees-lookups-test;
  test trees-tree-entries-test;
  test trees-walking-test;
  test trees-treebuilder-test;
end suite;

define suite libgit2-test-suite ()
  suite libgit2-repositories-test-suite;
  suite libgit2-objects-test-suite;
  suite libgit2-blobs-test-suite;
  suite libgit2-trees-test-suite;
end suite;
