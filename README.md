# Disk-Graph

</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![Delphi Multi](https://github.com/user-attachments/assets/2021081d-f8f1-4b76-889a-1be53081fb87)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) ![Disk Graph](https://github.com/user-attachments/assets/9288f6ff-228a-434f-9c2b-554c5a0c6962)  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![032026](https://github.com/user-attachments/assets/0fc2f280-2ec1-45b1-8947-57bfc6683ea0)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

# Use:
Select a folder on the left and click the 'Scan' button or Right-click on a section of the pie chart to browse it. Right-click on the pie chart to go up one level in the directory hierarchy.

The contents of the root directory (actually the entire disk) are stored (this takes quite a while the first time) which poses a problem if you switch disks (only the contents are stored) The free space checkbox, if selected, allows the free portion of the disk to be displayed when the root directory is examined.

</br>

![Disk](https://github.com/user-attachments/assets/886c0f81-d861-4bc8-87c1-5a12a437b6f2)

</br>

This program, like most programs that deal with the hard drive, uses a recursive algorithm. In this case, it's the FindRep procedure which calls itself.

Indeed, to browse a hard drive (or a directory on that drive), you list the files and subdirectories, then for each of these, their files and subdirectories, and so on... until you reach the end of a branch, where there are no more subdirectories.

Therefore, only one procedure is needed, listing the files and subdirectories of a directory, this procedure being re-executed for each of the subdirectories then considered as the base directory.

There are a few precautions to take with this type of procedure.

To execute correctly, the recursive procedure must not have its environment modified by a call to itself. It is necessary to declare all variables used by this procedure precisely.

Here, in the FindRep procedure, the variable Sd (TSearchRec) is modified within the procedure and is used both before and after the recursive call. Therefore, it MUST be declared as a local variable. Each time the procedure is called, a new SD variable is created, specific to that execution.

However, the variable R (String) could have been declared global. It is only used to pass the name of the directory to be explored, and its valueupon return from the FindRep procedure is no longer important.

"So why make this distinction? Just declare everything locally and we won't have any problems!" you might say. The problem is precisely that we might have problems. The local variables of a procedure or function are created on the stack (a specific memory area), and the number of nested calls of a recursive function is neither known nor controlled. While this number isn't very large when traversing a disk's directory tree (that's its greatest depth), it's a different story with the recursive sorting algorithm quicksort (see the Delphi Threads demo) when manipulating large sets. We then risk encountering the message "Stack Overflow".

</br>

# TeeChart:
TeeChart, in its standard version, has been an integral part of the Delphi installation (RAD Studio) for many years and is free for users of this IDE. This standard version is included in most Delphi editions (Professional, Enterprise, Architect).

The paid TeeChart Pro version, however, is a full-featured extension that must be purchased directly from Steema Software or through partners such as ComponentSource.

### Key points about the versions:

* TeeChart Standard (included in Delphi): Free, limited functionality, for basic charts.

* TeeChart Pro (paid): Offers advanced chart types, 3D capabilities, tools, and data analysis features. Prices for current versions (such as TeeChart Pro 2025/2026) often start in the three-figure range.

* Trial versions: These display a notification window (nag screen) and have limited functionality.










