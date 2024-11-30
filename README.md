# Build and serve

```bash
zola-v0.19.1-x86_64.exe build

zola-v0.19.1-x86_64.exe serve
```

## Deploy on Cloudflare pages

Changing the build command to on the Cloudflare Pages settings page. 

```bash
# [ERROR] Error: Pages only supports files up to 25 MiB in size
chmod +x zola-v0.19.1-x86_64-unknown-linux-gnu && ./zola-v0.19.1-x86_64-unknown-linux-gnu build

curl -L https://github.com/getzola/zola/releases/download/v0.19.1/zola-v0.19.1-x86_64-unknown-linux-gnu.tar.gz | tar xz && ./zola build

tar xz zola-v0.19.1-x86_64-unknown-linux-gnu.tar.gz && ./zola build
```

# Clone

```bash
git clone --recurse-submodules git@github.com:tuyenld/zola.git
```

# Release notes
- 2024/11/30
  - Upgrade Zola to version v0.19.1
  - Upgrade abridge theme to version 2.5.0

# Know bugs

1. [ ] NOT WORKING {url = "post", name = "Posts", slash = true, blank = false},