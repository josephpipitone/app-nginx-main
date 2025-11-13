# Custom Nginx Docker Image Setup

This repository provides a complete setup for building a custom Nginx Docker image using GitHub Actions. The image is based on the official Nginx image and includes custom HTML files served from the `/usr/share/nginx/html` directory.

## Repository Structure

- `Dockerfile`: Defines the Docker image build process.
- `www/`: Directory containing the HTML files to be served:
  - `index.html`: Main page with navigation links.
  - `hello.html`: Simple page displaying "hello world".
  - `nginx-test.html`: Test page displaying "nginx testing 12345".
- `.github/workflows/build.yml`: GitHub Actions workflow for automated building and pushing of the Docker image.

## Setup Instructions

1. **Create a GitHub Repository**:
   - Create a new public or private repository on GitHub.

2. **Clone the Repository**:
   - Clone the repository to your local machine.

3. **Add the Files**:
   - Copy the `Dockerfile`, `www/` directory, and `.github/workflows/` directory into your repository.

4. **Commit and Push**:
   - Add, commit, and push the files to the `main` branch.
   - The GitHub Actions workflow will automatically trigger on push to `main`.

## GitHub Actions Workflow

The workflow:
- Runs on the latest Ubuntu runner.
- Triggers on pushes to the `main` branch.
- Builds the Docker image using the `Dockerfile`.
- Scans the built image for vulnerabilities using Trivy (open source scanner).
- Pushes the image to GitHub Container Registry (`ghcr.io`) only if no critical or high-severity vulnerabilities are found, with tags:
  - `latest`: For the most recent build.
  - Commit SHA: For version-specific builds.

## Security Scanning

The workflow includes automated vulnerability scanning using [Trivy](https://github.com/aquasecurity/trivy), an open source container scanner. The scan checks for critical and high-severity vulnerabilities in the built image. If vulnerabilities are detected, the workflow fails and the image is not pushed to the registry. Scan results are uploaded to GitHub's Security tab for review.

This ensures that only secure images are published to your container registry.

## Repository Secrets

No additional repository secrets are required. The workflow uses the built-in `GITHUB_TOKEN` for authentication with GitHub Container Registry.

## Pulling and Running the Image

After the workflow completes successfully:

1. **Pull the Image**:
   ```bash
   docker pull ghcr.io/YOUR_USERNAME/YOUR_REPO:latest
   ```
   Replace `YOUR_USERNAME` with your GitHub username and `YOUR_REPO` with your repository name.

2. **Run the Container**:
   ```bash
   docker run -p 8080:80 ghcr.io/YOUR_USERNAME/YOUR_REPO:latest
   ```

3. **Access the Site**:
   - Open your browser and navigate to `http://localhost:8080`.
   - You should see the index page with links to the hello and nginx-test pages.

## Customization

- Modify the HTML files in the `www/` directory to customize the content.
- Update the `Dockerfile` if you need additional configurations or dependencies.
- Adjust the workflow in `.github/workflows/build.yml` for different triggers or build processes.