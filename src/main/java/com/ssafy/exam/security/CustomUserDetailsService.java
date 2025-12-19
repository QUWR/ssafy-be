package com.ssafy.exam.security;

import com.ssafy.exam.model.dao.MemberDao;
import com.ssafy.exam.model.dto.Member;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberDao memberDao;

    public CustomUserDetailsService(MemberDao memberDao) {
        this.memberDao = memberDao;
    }

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Member member = memberDao.selectByEmail(email);
        if (member == null) {
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
        return member;
    }
}
