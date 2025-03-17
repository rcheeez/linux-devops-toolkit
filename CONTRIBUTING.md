# Contributing to Linux DevOps Toolkit 🚀

Thank you for considering contributing to **Linux DevOps Toolkit**! Your contributions help improve automation and make DevOps tool installations more accessible across different Linux distributions. 🛠️🐧

## 📌 How to Contribute

### 1️⃣ Fork the Repository
Click the **Fork** button at the top right of the repository page to create your own copy.

### 2️⃣ Clone Your Fork
```bash
git clone https://github.com/your-username/linux-devops-toolkit.git
cd linux-devops-toolkit
```

### 3️⃣ Create a New Branch
```bash
git checkout -b feature-name
```
Give your branch a meaningful name related to your contribution.

### 4️⃣ Add Your Changes
- Add **new installation scripts** for DevOps tools.
- Improve **existing scripts** (optimizations, bug fixes, security enhancements).
- Update **documentation** (README, instructions, or script comments).

### 5️⃣ Test Your Scripts
Before submitting, ensure your script:
✅ Runs without errors.
✅ Works on the target Linux distribution.
✅ Follows best practices for installation and security.

### 6️⃣ Commit Your Changes
```bash
git add .
git commit -m "Added install script for [tool] on [distro]"
```

### 7️⃣ Push to Your Fork
```bash
git push origin feature-name
```

### 8️⃣ Create a Pull Request (PR)
- Go to the **original repository** on GitHub.
- Click **New Pull Request**.
- Select your branch and describe your changes.
- Submit the PR for review. 🚀

## 🛠️ Contribution Guidelines
✅ Follow best practices for **Bash scripting**.
✅ Use **comments** to explain script functionality.
✅ Ensure scripts are **idempotent** (running them multiple times should not break anything).
✅ Stick to the **repository structure**:
  ```
  /linux-devops-toolkit
    /distro-name/
      - install_tool1.sh
      - install_tool2.sh
  ```
✅ No hardcoded values – use environment variables or configuration files if needed.

## 💬 Need Help?
If you have questions or need help, feel free to **open an issue** or start a discussion in the repository.

## 🎉 Thank You!
Your contributions make this project better for everyone. Happy coding! 🚀
