default:
  @just --list

rebuild-pre:
  git add .

rebuild-post:
  just check-sops
 
rebuild:
  just rebuild-pre
  scripts/system-flake-rebuild.sh

rebuild-full:
  just rebuild-pre
  scripts/system-flake-rebuild.sh
  just rebuild-post

check-sops:
  scripts/check-sops.sh

diff:
  git diff ':!flake.lock'