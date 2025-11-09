package br.com.restfuljava.repository;

import br.com.restfuljava.model.Book;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BookRepository extends JpaRepository<Book, Long> {}