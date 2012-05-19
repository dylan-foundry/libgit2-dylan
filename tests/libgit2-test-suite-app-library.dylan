module: dylan-user

define library libgit2-test-suite-app
  use testworks;
  use libgit2-test-suite;
end library;

define module libgit2-test-suite-app
  use testworks;
  use libgit2-test-suite;
end module;
