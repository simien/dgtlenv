# GitHub Setup Todo

> **Note:** This todo list is for tasks required before the initial GitHub launch. Funding, documentation, and community tasks have been moved to their own lists.

## 🎯 Current Tasks

### High Priority
- [ ] **Git Repository Initialization**
  - [ ] Run setup script: `./scripts/setup-github.sh -r https://github.com/simien/dgtlenv.git`
  - [ ] Verify all files are properly tracked
  - [ ] Test GitHub Actions workflow
  - [ ] Confirm issue templates work

### Security Verification (Pre-GitHub)
- [ ] **File Content Scan**
  - [ ] Search for API keys: `grep -r "api_key\|API_KEY\|apikey" .`
  - [ ] Search for passwords: `grep -r "password\|PASSWORD\|passwd" .`
  - [ ] Search for tokens: `grep -r "token\|TOKEN\|secret" .`
  - [ ] Search for URLs: `grep -r "https://\|http://" .`
- [ ] **Configuration Files**
  - [ ] Review `.env` files (should be in .gitignore)
  - [ ] Check for local configuration files
  - [ ] Verify no database credentials
  - [ ] Review Docker configurations
- [ ] **Script Security**
  - [ ] Check for hardcoded paths
  - [ ] Review for sudo commands
  - [ ] Verify no dangerous operations
  - [ ] Check file permissions

### Post-Setup Security (After Initial Push)
- [ ] **Repository Security**
  - [ ] Enable branch protection
  - [ ] Set up security scanning
  - [ ] Configure dependency alerts
  - [ ] Enable secret scanning

---

**Last Updated:** 2025-07-25  
**Priority:** High  
**Status:** In Progress

---

> **Moved tasks:**
> - Funding setup → `funding-todo.md`
> - Documentation enhancements → `documentation-todo.md`
> - Community setup → `community-todo.md` (if needed)
> - Timestamp verification → `timestamp-verification-todo.md` (optional/last) 