module: libgit2-test-suite
synopsis: Test suite for the libgit2 library.

define suite libgit2-test-suite ()
  test basic-libgit2-test;
end suite;

define test basic-libgit2-test ()
  let (err, repo) = git-repository-init("./temp_repo", 0);
  check-equal("git-repository-init did not error", err, 0);

  check-condition("git-repository-open errors when no repo",
                  <libgit2-error>,
                  git-repository-open("./temp_repo2"));
end test basic-libgit2-test;
