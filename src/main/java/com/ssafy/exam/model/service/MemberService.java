package com.ssafy.exam.model.service;

import com.ssafy.exam.model.dao.MemberDao;
import com.ssafy.exam.model.dto.Member;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MemberService {

    private final MemberDao memberDao;
    private final PasswordEncoder passwordEncoder;

    public MemberService(MemberDao memberDao, PasswordEncoder passwordEncoder) {
        this.memberDao = memberDao;
        this.passwordEncoder = passwordEncoder;
    }

    public boolean register(Member member) {
        if (memberDao.selectByEmail(member.getEmail()) != null) {
            return false;
        }
        if (member.getRole() == null || member.getRole().isEmpty()) {
            member.setRole("USER");
        }
        member.setPassword(passwordEncoder.encode(member.getPassword()));
        memberDao.insert(member);
        return true;
    }

    public Member login(String email, String password) {
        Member member = memberDao.selectByEmail(email);
        if (member != null && passwordEncoder.matches(password, member.getPassword())) {
            return member;
        }
        return null;
    }

    public Member getMemberByMno(int mno) {
        return memberDao.selectByMno(mno);
    }

    public Member getMemberByEmail(String email) {
        return memberDao.selectByEmail(email);
    }

    public List<Member> getAllMembers() {
        return memberDao.selectAll();
    }

    public boolean updateMember(Member member) {
        Member existing = memberDao.selectByMno(member.getMno());
        if (existing == null) {
            return false;
        }

        if (member.getPassword() == null || member.getPassword().isEmpty()) {
            member.setPassword(existing.getPassword());
        } else {
            member.setPassword(passwordEncoder.encode(member.getPassword()));
        }

        memberDao.update(member);
        return true;
    }

    public boolean deleteMember(int mno) {
        memberDao.delete(mno);
        return true;
    }

    public boolean isEmailAvailable(String email) {
        return memberDao.selectByEmail(email) == null;
    }
}