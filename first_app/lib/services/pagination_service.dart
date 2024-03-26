class PaginationService {
  int currentPage = 1;

  void nextPage() {
    currentPage++;
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
    }
  }

  int getCurrentPage() {
    return currentPage;
  }
}
