# Apt Package Inspection


<details>
  <summary>
    <b>Checking apt deb files</b>
  </summary>

  1. Create a temporary directory
  ```sh
  folder=$(mktemp -d)
  cd ${folder}
  ```

  2. Download the deb file (if not already done)
  ```sh
  apt download <package-name> # e.g., apt download sqlfluff
  ```

  3. Check the contents of the deb file
  ```sh
  dpkg -c <package-name>.deb # e.g., dpkg -c sqlfluff_1.4.5-2_all.deb
  ```

  4. Extract the deb file to a temporary directory
  ```sh
  # Extract the package itself
  dpkg -x <package-name>.deb <content-folder> # e.g., pkg -x sqlfluff_1.4.5-2_all.deb sqlfluff
  # Extract the control files
  dpkg-deb -e <package>.deb <control-folder> # dpkg -e sqlfluff_1.4.5-2_all.deb control
  ```
  4. List the contents of the extracted directory
  ```sh
  ls -l ${folder}
  ```
  6. Check the control files for dependencies and other information
  ```sh
  cat ${folder}/DEBIAN/control
  ```

</details>