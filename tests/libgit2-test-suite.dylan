module: libgit2-test-suite
synopsis: Test suite for the libgit2 library.

define constant $repository-url = "git://github.com/github/testrepo.git";
define constant $commit-sha = "78cf42b3249a69c0602b8bcb074cb6a61156787f";

define function default-repository-and-oid
    () => (repo :: <git-repository*>, oid :: <git-oid*>)
  let oid = git-oid-from-string($commit-sha);

  let repo = git-repository-open("./temp_testrepo");
  values(repo, oid)
end function default-repository-and-oid;

// Most tests taken from http://libgit2.github.com/docs/guides/101-samples/
define test init-simple-test ()
  // with working directory...
  let repo = git-repository-init("./temp_repo");
  check-instance?("git-repository-init returns a git-repository",
                  <git-repository*>, repo);

  // ...or bare:
  let repo = git-repository-init("./temp_repo2.git", bare?: #t);

  check-condition("git-repository-open errors when no repo",
                  <libgit2-error>,
                  git-repository-open("./temp_no_repo"));
end test;

define test init-options-test ()
  let repo = git-repository-init("./temp_repo_init_options",
                                 flags: $GIT-REPOSITORY-INIT-MKDIR,
                                 description: "My repository has a custom description.",
                                 origin-url: "http://example.org/");
  check-instance?("git-repository-init returns a git-repository",
                  <git-repository*>, repo);

  // after the change
  let repo2 = git-repository-init("./temp_repo_init_options",
                                  flags: $GIT-REPOSITORY-INIT-MKDIR,
                                  description: "My repository has a custom description.",
                                  origin-url: "http://example.org/");
  check-instance?("git-repository-init returns a git-repository",
                  <git-repository*>, repo2);
end test;

define test clone-simple-test ()
  let repo = git-clone($repository-url, "./temp_testrepo");
  check-instance?("git-clone returns a git-repository",
                  <git-repository*>, repo);
end test;

define test clone-progress-test ()
  // TODO: implement me
end test;

define test clone-repo-test ()
  let repo = git-repository-init("./temp_repo_test");
  let origin = git-remote-create(repo, "origin", $repository-url);
  check-instance?("git-remote-create returns a git-remote",
                  <git-remote*>, origin);

  // customize the remote, set callbacks etc.

  assert-no-errors(git-clone-into(repo, origin, branch: "master"));
end test;

define test clone-mirror-test ()
  let repo = git-repository-init("./temp_clone_mirror", bare?: #t);

  // create an 'origin' remote with the mirror fetch refspec
  let origin = git-remote-create-with-fetchspec(repo, "origin",
                                                $repository-url,
                                                "+refs/*:refs/*");
  check-instance?("git-remote-create-with-fetchspec returns a git-remote",
                  <git-remote*>, origin);

  let cfg = git-repository-config(repo);
  check-instance?("git-repository-config returns a git-config",
                  <git-config*>, cfg);

  assert-no-errors(git-config-set-bool(cfg, "remote.origin.mirror", #t));

  assert-no-errors(git-clone-into(repo, origin));
end test;

define test open-simple-test ()
  // open repository from clone-simple-test
  let repo = git-repository-open("./temp_testrepo");
  check-instance?("git-repository-open returns a git-repository",
                  <git-repository*>, repo);
end test;

define test open-options-test ()
  // open repository, walking up from given directory to find root
  let _ = git-repository-open("./temp_testrepo/test", flags: 0);

  // open repository in given directory (or fail if not a repository)
  // this call should fail
  check-condition("git-repository-open(path, flags) error",
                  <libgit2-error>,
                  git-repository-open("./temp_testrepo/test",
                                      flags: $GIT-REPOSITORY-OPEN-NO-SEARCH));

  // open repository with "ceiling" directories list to limit walking up
  let _ = git-repository-open("./temp_testrepo/test",
                              flags: $GIT-REPOSITORY-OPEN-CROSS-FS,
                              ceiling-directories: "/tmp:./");
end test;

define test open-bare-test ()
  let repo = git-repository-open-bare("./temp_repo2.git");
  check-instance?("git-repository-open-bare returns a git-repository",
                  <git-repository*>, repo);
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
  let oid = git-oid-from-string(sha);
  check-instance?("git-oid-from-string returns a git-oid",
                  <git-oid*>, oid);

  let newsha = git-oid-to-string(oid);
  assert-equal(sha, newsha);
end test;

define test lookups-test ()
  let (repo, oid) = default-repository-and-oid();

  let commit = git-commit-lookup(repo, oid);
  check-instance?("git-commit-lookup returns a git-commit",
                  <git-commit*>, commit);

  git-commit-free(commit);
end test;

define suite libgit2-objects-test-suite ()
  test SHAs-and-OIDs-test;
  test lookups-test;
end suite;

define test blobs-content-test ()
  // ./temp_testrepo/test/alias.c
  let sha = "6c8775cb01546b6855a15f07aae660585d48b491";
  let oid = git-oid-from-string(sha);
  check-instance?("git-oid-from-string returns a git-oid",
                  <git-oid*>, oid);

  let repo = default-repository-and-oid();

  let blob = git-blob-lookup(repo, oid);
  check-instance?("git-blob-lookup returns a git-blob",
                  <git-blob*>, blob);

  let raw-size = git-blob-rawsize(blob);
  
  let raw-content = git-blob-rawcontent(blob);
  check-false("git-blob-rawcontent did return something", null-pointer?(raw-content));

  let filtered-content = git-blob-filtered-content(blob, "test/alias.c", #t);
  check-instance?("git-blob-filtered-content returns a git-buf",
                  <git-buf*>, filtered-content);
end test;

define test blobs-create-test ()
  let repo = default-repository-and-oid();

  let blob1 = git-blob-create-from-working-directory(repo, "test/alias.c");
  check-instance?("git-blob-create-from-working-directory returns a git-oid",
                  <git-oid*>, blob1);

  let blob2 = git-blob-create-from-disk(repo, "/etc/hosts");
  check-instance?("git-blob-create-from-disk returns a git-oid",
                  <git-oid*>, blob2);

  let blob3 = git-blob-create-from-buffer(repo, "Hello there!");
  check-instance?("git-blob-create-from-buffer returns a git-oid",
                  <git-oid*>, blob3);
end test;

define suite libgit2-blobs-test-suite ()
  test blobs-content-test;
  test blobs-create-test;
end suite;

define test trees-lookups-test ()
  let (repo, oid) = default-repository-and-oid();
  let commit = git-commit-lookup(repo, oid);
  check-instance?("git-commit-lookup returns a git-commit",
                  <git-commit*>, commit);

  let commit-tree = git-commit-tree(commit);
  check-instance?("git-commit-tree returns a git-tree",
                  <git-tree*>, commit-tree);

  git-commit-free(commit);

  let tree-sha = "cac308be17ad33f3a5bcb2ef2e5eb34f4e28100c";
  let tree-oid = git-oid-from-string(tree-sha);

  let tree = git-tree-lookup(repo, tree-oid);
  check-instance?("git-tree-lookup returns a git-tree",
                  <git-tree*>, tree);

  let entry = git-tree-entry-by-index(tree, 0);
  if (git-tree-entry-type(entry) == $GIT-OBJ-TREE)
    let subtree = git-tree-lookup(tree, git-tree-entry-id(entry));
    check-instance?("git-tree-lokkup(tree, git-tree-entry-id(entry)) returns a git-tree",
                    <git-tree*>, subtree);
  end if;
end test;

define test trees-tree-entries-test ()
  let repo = default-repository-and-oid();

  let obj = git-revparse-single(repo, "HEAD^{tree}");
  check-instance?("git-revparse-single returns a git-object",
                  <git-object*>, obj);

  let tree = pointer-cast(<git-tree*>, obj);
  assert-true(size(tree) > 0);

  let entry = git-tree-entry-by-index(tree, 0);
  let name = git-tree-entry-name(entry); // file name
  assert-false(null-pointer?(name));
  let object-type = git-tree-entry-type(entry); // blob or tree
  let mode = git-tree-entry-filemode(entry); // NIX filemode

  let entry2 = git-tree-entry-by-path(tree, "test/alloc.c");
  check-instance?("git-tree-entry-by-path returns a git-tree-entry",
                  <git-tree-entry*>, entry2);
  git-tree-entry-free(entry2); // caller has to free this one
end test;

define test trees-walking-test ()
  // TODO: implement me
end test;

define test trees-treebuilder-test ()
  let bld = git-treebuilder-create();

  // add some entries
  let repo = default-repository-and-oid();
  let obj = git-revparse-single(repo, "HEAD:test/alloc.c");

  git-treebuilder-insert(bld,
                         "alloc.c", // filename
                         git-object-id(obj), // OID
                         #o100644); // mode
  git-object-free(obj);

  let obj = git-revparse-single(repo, "HEAD:test/alias.c");
  git-treebuilder-insert(bld,
                         "alias.c",
                         git-object-id(obj),
                         #o100644);
  git-object-free(obj);

  let tree-oid = git-treebuilder-write(repo, bld);
  check-instance?("git-treebuilder-write returns a git-oid",
                  <git-oid*>, tree-oid);
  git-treebuilder-free(bld);
end test;

define suite libgit2-trees-test-suite ()
  test trees-lookups-test;
  test trees-tree-entries-test;
  test trees-walking-test;
  test trees-treebuilder-test;
end suite;

define test commits-lookups-test ()
  let (repo, oid) = default-repository-and-oid();
  let commit = git-commit-lookup(repo, oid);
  check-instance?("git-commit-lookup returns a git-commit",
                  <git-commit*>, commit);
end test;

define test commits-properties-test ()
  let (repo, oid) = default-repository-and-oid();
  let commit = git-commit-lookup(repo, oid);

  let oid = git-commit-id(commit);
  check-instance?("git-commit-id returns a git-oid",
                  <git-oid*>, oid);
  let encoding = git-commit-message-encoding(commit);
  check-instance?("git-commit-message-encoding returns a string",
                  <string>, encoding);
  let msg = git-commit-message(commit);
  check-instance?("git-commit-message returns a string",
                  <string>, msg);
  let summary = git-commit-summary(commit);
  check-instance?("git-commit-summary returns a string",
                  <string>, summary);
  let time = git-commit-time(commit);
  check-instance?("git-commit-time returns an integer",
                  <integer>, time);
  let offset-in-minutes = git-commit-time-offset(commit);
  check-instance?("git-commit-time-offset returns an integer",
                  <integer>, offset-in-minutes);
  let committer = git-commit-committer(commit);
  check-instance?("git-commit-committer returns a git-signature",
                  <git-signature*>, committer);
  let author = git-commit-author(commit);
  check-instance?("git-commit-author returns a git-signature",
                  <git-signature*>, author);
  let header = git-commit-raw-header(commit);
  check-instance?("git-commit-raw-header returns a string",
                  <string>, header);
  let tree-id = git-commit-tree-id(commit);
  check-instance?("git-commit-tree-id returns a git-oid",
                  <git-oid*>, tree-id);
end test;

define test commits-parents-test ()
  let (repo, oid) = default-repository-and-oid();
  let commit = git-commit-lookup(repo, oid);

  let count = git-commit-parent-count(commit);
  for (i from 0 below count)
    let nth-parent-id = git-commit-parent-id(commit, i);
    check-instance?("git-commit-parent-id returns a git-oid",
                    <git-oid*>, nth-parent-id);

    let parent = git-commit-parent(commit, i);
    check-instance?("git-commit-parent returns a git-commit",
                    <git-commit*>, parent);
  end for;
  let nth-ancestor = git-commit-nth-gen-ancestor(commit, 3);
  check-instance?("git-commit-nth-gen-ancestor returns a git-commit",
                  <git-commit*>, nth-ancestor);
end test;

define test commits-create-test ()
  let repo = default-repository-and-oid();
  let parent-id = git-reference-name-to-id(repo, "HEAD");
  let parent1 = git-commit-lookup(repo, parent-id);

  let me = git-signature-now("Me", "me@example.com");
  check-instance?("git-signature-now returns a git-signature",
                  <git-signature*>, me);

  let parents = make(<vector>, size: 1);
  parents[0] := parent1;

  let blob-id = git-blob-create-from-buffer(repo, "Hello there!");
  let blob = git-blob-lookup(repo, blob-id);
  let bld = git-treebuilder-create();
  git-treebuilder-insert(bld, "README.txt", blob-id, $GIT-FILEMODE-BLOB);
  let tree-oid = git-treebuilder-write(repo, bld);
  let tree = git-tree-lookup(repo, tree-oid);
  let commit-id = git-commit-create(repo,
                                    "HEAD", // name or ref to update
                                    me, // author
                                    me, // commiter
                                    "UTF-8", // message encoding
                                    "The message", // message
                                    tree, // root tree
                                    parents);
  check-instance?("git-commit-create returns a git-oid",
                  <git-oid*>, commit-id);
end test;

define suite libgit2-commits-test-suite ()
  test commits-lookups-test;
  test commits-properties-test;
  test commits-parents-test;
  test commits-create-test;
end suite;

define test references-lookups-test ()
  let repo = default-repository-and-oid();

  let ref1 = git-reference-lookup(repo, "refs/heads/master");
  check-instance?("git-reference-lookup returns a git-reference",
                  <git-reference*>, ref1);

  let ref2 = git-reference-dwim(repo, "master");
  check-instance?("git-reference-dwim returns a git-reference",
                  <git-reference*>, ref2);

  let ref3 = git-reference-name-to-id(repo, "HEAD");
  check-instance?("git-reference-name-to-id returns a git-oid",
                  <git-oid*>, ref3);
end test;

define test references-listing-test ()
  let repo = default-repository-and-oid();

  let refs = git-reference-list(repo);
  assert-true(refs);
  for (ref in refs)
    check-instance?("git-reference-list returns a sequence of strings",
                    <string>, ref);
  end for;
end test;

define test references-create-direct-test ()
  let (repo, oid) = default-repository-and-oid();

  let ref = git-reference-create(repo,
                                "refs/heads/direct", // name
                                oid, // target
                                force?: #t);
  check-instance?("git-reference-create returns a git-reference",
                  <git-reference*>, ref);
end test;

define test references-create-symbolic-test ()
  let (repo, oid) = default-repository-and-oid();

  let ref = git-reference-create(repo,
                                 "refs/heads/direct", // name
                                 "refs/heads/master", // target
                                 force?: #t);
  check-instance?("git-reference-create returns a git-reference",
                  <git-reference*>, ref);
end test;

define suite libgit2-references-test-suite ()
  test references-lookups-test;
  test references-listing-test;
  test references-create-direct-test;
  test references-create-symbolic-test;
end suite;

define constant $tag-name = "v0.5.0";
define constant $lightweight-tag-name = "v1.0.0";

define test tags-lookups-annotations-test ()
  let repo = default-repository-and-oid();
  let tag = git-revparse-single(repo, $tag-name);
  check-instance?("git-revparse-single returns a git-object",
                  <git-object*>, tag);
  let tag-oid = git-object-id(tag);

  let tag2 = git-tag-lookup(repo, tag-oid);
  check-instance?("git-tag-lookup returns a git-tag",
                  <git-tag*>, tag2);
end test;

define test tags-create-lightweight-test ()
  let repo = default-repository-and-oid();

  let target = git-revparse-single(repo, "HEAD^{commit}");
  check-instance?("git-revparse-single returns a git-object",
                  <git-object*>, target);

  let tag-oid = git-tag-create-lightweight(repo, $lightweight-tag-name, target, force?: #t);
  check-instance?("git-tag-create-lightweight returns a git-oid",
                  <git-oid*>, tag-oid);
end test;

define test tags-create-annotated-test ()
  let repo = default-repository-and-oid();

  let target = git-revparse-single(repo, "HEAD^{commit}");

  let tagger = git-signature-now("Me", "me@example.com");
  let tag-oid = git-tag-create(repo, $tag-name, target, tagger, "Released", force?: #t);
  check-instance?("git-tag-create returns a git-oid",
                  <git-oid*>, tag-oid);
end test;

define test tags-listing-all-test ()
  let repo = default-repository-and-oid();

  let tags = git-tag-list(repo);
  for (tag in tags)
    check-instance?("git-tag-list returns a sequence of strings",
                    <string>, tag);
    let id = git-revparse-single(repo, tag);
    check-instance?("git-revparse-single returns a git-object",
                    <git-object*>, id);
  end for;
end test;

define test tags-listing-glob-test ()
  let repo = default-repository-and-oid();

  let tags = git-tag-list(repo, pattern: "v*");
  for (tag in tags)
    check-instance?("git-tag-list returns a sequence of strings",
                    <string>, tag);
    let id = git-revparse-single(repo, tag);
    check-instance?("git-revparse-single returns a git-object",
                    <git-object*>, id);
  end for;
end test;

define suite libgit2-tags-test-suite ()
  test tags-create-lightweight-test;
  test tags-create-annotated-test;
  test tags-lookups-annotations-test;
  test tags-listing-all-test;
  test tags-listing-glob-test;
end suite;

define test index-loading-test ()
  let repo = default-repository-and-oid();

  let idx1 = git-repository-index(repo);
  check-instance?("git-repository-index returns a git-index",
                  <git-index*>, idx1);

  let idx2 = git-index-open("./temp_testrepo/.git/index");
  check-instance?("git-index-open returns a git-index",
                  <git-index*>, idx2);
end test;

define test creating-in-memory-test ()
  let idx = git-index-new();
  check-instance?("git-index-new returns a git-index",
                  <git-index*>, idx);
end test;

define test index-disk-test ()
  let repo = default-repository-and-oid();
  let idx = git-repository-index(repo);

  // make the in-memory index match what's on disk
  assert-no-errors(git-index-read(idx, force?: #t));

  // write the in-memory index to disk
  assert-no-errors(git-index-write(idx));
end test;

define test index-trees-test ()
  let repo = default-repository-and-oid();

  let tree = git-revparse-single(repo, "HEAD~^{tree}");
  tree := pointer-cast(<git-tree*>, tree);

  let repo-idx = git-repository-index(repo);
  check-instance?("git-repository-index returns a git-index",
                  <git-index*>, repo-idx);

  assert-no-errors(git-index-read-tree(repo-idx, tree));

  // write the index contents to the ODB as a tree
  let tree-oid = git-index-write-tree(repo-idx);
  check-instance?("git-index-write-tree returns a git-oid",
                  <git-oid*>, tree-oid);

  // in-memory indexes can write trees to any repo
  let other-repo = git-repository-open("./temp_repo");
  let tree-oid2 = git-index-write-tree(repo-idx, repository: other-repo);
  check-instance?("git-index-write-tree returns a git-oid",
                  <git-oid*>, tree-oid2);
end test;

define test index-entries-test ()
  let repo = default-repository-and-oid();
  let idx = git-repository-index(repo);

  // access by index
  let count = git-index-entry-count(idx);
  for (i from 0 below count)
    let entry = git-index-get-by-index(idx, i);
    check-instance?("git-index-get-by-index returns a git-index-entry",
                    <git-index-entry*>, entry);
  end for;

  // access by path
  let entry = git-index-get-by-path(idx, "test/alloc.c");
  check-instance?("git-index-get-by-path returns a git-index-entry",
                  <git-index-entry*>, entry);
end test;

define function match
    (path :: <string>, spec :: <string>, payload)
 => (ret :: <integer>)
  0
end function;

define C-callable-wrapper callback-of-match of \match
  parameter path :: <C-string>;
  parameter spec :: <C-string>;
  parameter payload :: <C-void*>;
  result res :: <C-int>;
end C-callable-wrapper;

define test index-conflicts-test ()
  // TODO: implement me
end test;

define test index-add-and-remove-test ()
  let repo = default-repository-and-oid();
  let idx = git-repository-index(repo);

  // force a single file to be added (even if it is ignored)
  assert-no-errors(git-index-add-by-path(idx, "test/alloc.c"));

  // ... or removed
  assert-no-errors(git-index-remove-by-path(idx, "test/alloc.c"));

  let paths = #["test/*"];
  assert-no-errors(git-index-add-all(idx, paths,
                                     callback: callback-of-match,
                                     flags: $GIT-INDEX-ADD-DEFAULT));

  assert-no-errors(git-index-remove-all(idx, paths, callback: callback-of-match));

  assert-no-errors(git-index-update-all(idx, paths, callback: callback-of-match));
end test;

define suite libgit2-index-test-suite ()
  test index-loading-test;
  test creating-in-memory-test;
  test index-disk-test;
  test index-trees-test;
  test index-entries-test;
  test index-conflicts-test;
  test index-add-and-remove-test;
end suite;

define test status-iterating-test ()
  let repo = default-repository-and-oid();
  let opts = make(<git-status-options*>);
  let statuses = git-status-list(repo, opts);
  for (i from 0 below size(statuses))
    let status = git-status-by-index(statuses, i);
    check-instance?("git-status-by-index returns a git-status-entry",
                    <git-status-entry*>, status);
  end for;
end test;

define test status-iterating-forward-iteration-protocol-test ()
  let repo = default-repository-and-oid();
  let opts = make(<git-status-options*>);
  for (status in git-status-list(repo, opts))
    check-instance?("git-status-list returns a list of git-status-entry",
                    <git-status-entry*>, status);
  end for;
end test;

define suite libgit2-status-test-suite ()
  test status-iterating-test;
  test status-iterating-forward-iteration-protocol-test;
end suite;

define test diff-index-to-working-directory-test ()
  // like git diff
  let repo = default-repository-and-oid();
  let diff = git-diff-index-to-working-directory(repo);
  check-instance?("git-diff-index-to-working-directory returns a git-diff",
                  <git-diff*>, diff);
end test;

define test diff-head-to-index-test ()
  // like git diff --cached
  let repo = default-repository-and-oid();
  let obj = git-revparse-single(repo, "HEAD^{tree}");

  let tree = git-tree-lookup(repo, git-object-id(obj));

  let diff = git-diff-tree-to-index(repo, tree);
  check-instance?("git-diff-tree-to-index returns a git-diff",
                  <git-diff*>, diff);
end test;

define test diff-head-to-working-directory-test ()
  // like git diff HEAD
  let repo = default-repository-and-oid();
  let obj = git-revparse-single(repo, "HEAD^{tree}");

  let tree = git-tree-lookup(repo, git-object-id(obj));

  let diff = git-diff-tree-to-working-directory-with-index(repo, tree);
  check-instance?("git-diff-tree-to-working-directory-with-index returns a git-diff",
                  <git-diff*>, diff);
end test;

define test diff-commit-to-its-parent-test ()
  // like git show <commit>
  let repo = default-repository-and-oid();
  let obj = git-revparse-single(repo, $commit-sha);
  let commit = git-commit-lookup(repo, git-object-id(obj));
  let parent = git-commit-parent(commit, 0);

  let commit-tree = git-commit-tree(commit);
  let parent-tree = git-commit-tree(parent);

  let diff = git-diff-tree-to-tree(repo, commit-tree, parent-tree);
  check-instance?("git-diff-tree-to-tree returns a git-diff",
                  <git-diff*>, diff);
end test;

define test diff-rename-detection-test ()
  let repo = default-repository-and-oid();
  let diff = git-diff-index-to-working-directory(repo);
  let opts = make(<git-diff-find-options*>,
                  flags: logior($GIT-DIFF-FIND-RENAMES, $GIT-DIFF-FIND-COPIES, $GIT-DIFF-FIND-FOR-UNTRACKED));
  assert-no-errors(git-diff-find-similar(diff, opts));
end test;

define function each-file
    (diff-delta :: <git-diff-delta*>, progress :: <float>, payload)
 => (res :: <integer>)
  // do something
  0
end function;

define C-callable-wrapper callback-of-each-file of \each-file
  parameter diff-delta :: <git-diff-delta*>;
  parameter progress :: <C-float>;
  parameter payload :: <C-void*>;
  result res :: <C-int>;
end C-callable-wrapper;

define function each-hunk
    (diff-delta :: <git-diff-delta*>, hunk :: <git-diff-hunk*>, payload)
 => (res :: <integer>)
  // do something
  0
end function;

define C-callable-wrapper callback-of-each-hunk of \each-hunk
  parameter diff-delta :: <git-diff-delta*>;
  parameter hunk :: <git-diff-hunk*>;
  parameter payload :: <C-void*>;
  result res :: <C-int>;
end C-callable-wrapper;

define function each-line
    (diff-delta :: <git-diff-delta*>, hunk :: <git-diff-hunk*>, line :: <git-diff-line*>, payload)
 => (res :: <integer>)
  // do something
  0
end function;

define C-callable-wrapper callback-of-each-line of \each-line
  parameter diff-delta :: <git-diff-delta*>;
  parameter hunk :: <git-diff-hunk*>;
  parameter line :: <git-diff-line*>;
  parameter payload :: <C-void*>;
  result res :: <C-int>;
end C-callable-wrapper;

define test diff-iterating-deltas-test ()
  let repo = default-repository-and-oid();
  let diff = git-diff-index-to-working-directory(repo);
  assert-no-errors(git-diff-foreach(diff, callback-of-each-file,
                                    hunk-callback: callback-of-each-hunk,
                                    line-callback: callback-of-each-line));
end test;

define test diff-generating-patch-test ()
  let repo = default-repository-and-oid();
  let diff = git-diff-index-to-working-directory(repo);
  let patch = git-patch-from-diff(diff, 0);
  check-instance?("git-patch-from-diff returns a git-patch",
                  <git-patch*>, patch);
end test;

define suite libgit2-diff-test-suite ()
  test diff-index-to-working-directory-test;
  test diff-head-to-index-test;
  test diff-head-to-working-directory-test;
  test diff-commit-to-its-parent-test;
  test diff-rename-detection-test;
  test diff-iterating-deltas-test;
  test diff-generating-patch-test;
end suite;

define suite libgit2-test-suite ()
  suite libgit2-repositories-test-suite;
  suite libgit2-objects-test-suite;
  suite libgit2-blobs-test-suite;
  suite libgit2-trees-test-suite;
  suite libgit2-commits-test-suite;
  suite libgit2-references-test-suite;
  suite libgit2-tags-test-suite;
  suite libgit2-index-test-suite;
  suite libgit2-status-test-suite;
  suite libgit2-diff-test-suite;
end suite;
