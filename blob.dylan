module: libgit2
synopsis: blob related functions
author: Francesco Ceccon
copyright: See LICENSE file in this distribution.

define function git-blob-filtered-content
    (blob :: <git-blob*>, as-path :: <string>, check-for-binary-data? :: <boolean>)
 => (buf :: <git-buf*>)
  let buf = make(<git-buf*>);
  %git-blob-filtered-content(buf, blob, as-path, if (check-for-binary-data?) 1 else 0 end);
  buf
end function git-blob-filtered-content;

define function git-blob-create-from-working-directory
    (repo :: <git-repository*>, path :: <string>)
 => (oid :: <git-oid*>)
  let oid = make(<git-oid*>);
  %git-blob-create-fromworkdir(oid, repo, path);
  oid
end function git-blob-create-from-working-directory;

define function git-blob-create-from-disk
    (repo :: <git-repository*>, path :: <string>)
 => (oid :: <git-oid*>)
  let oid = make(<git-oid*>);
  %git-blob-create-fromdisk(oid, repo, path);
  oid
end function git-blob-create-from-disk;

define function git-blob-create-from-buffer
    (repo :: <git-repository*>, path :: <string>)
 => (oid :: <git-oid*>)
  with-c-string (c-path = path)
    let oid = make(<git-oid*>);
    %git-blob-create-frombuffer(oid, repo, pointer-cast(<C-void*>, c-path), size(path));
    oid
  end
end function git-blob-create-from-buffer;
