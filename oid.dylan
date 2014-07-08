module: libgit2
synopsis: oid related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define method git-oid-to-string (oid :: <git-oid*>) => (str :: <C-string>)
  %git-oid-allocfmt(oid)
end method git-oid-to-string;

define method git-oid-from-string (sha :: <string>) => (err, oid :: <git-oid*>)
  let oid = make(<git-oid*>);
  let err = %git-oid-from-string(oid, sha);
  values(err, oid)
end method git-oid-from-string;

