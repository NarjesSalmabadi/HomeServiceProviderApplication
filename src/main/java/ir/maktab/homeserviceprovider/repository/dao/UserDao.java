package ir.maktab.homeserviceprovider.repository.dao;

import ir.maktab.homeserviceprovider.repository.entity.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserDao extends CrudRepository<User,Integer> {

    Optional<User> findUserByEmail(String email);

}
