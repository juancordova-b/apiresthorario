package com.cordova.apihorariomed.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cordova.apihorariomed.entity.Schedule;
import com.cordova.apihorariomed.repository.ScheduleRepository;

@Service
public class ScheduleService {

    @Autowired
    private ScheduleRepository scheduleRepository;

    public List<Schedule> findAll() {
        return scheduleRepository.findAll();
    }

    public Optional<Schedule> findById(Integer id) {
        return scheduleRepository.findById(id);
    }

    public Schedule save(Schedule schedule) {
        return scheduleRepository.save(schedule);
    }

    public void deleteById(Integer id) {
        scheduleRepository.deleteById(id);
    }

    public Schedule update(Integer id, Schedule scheduleDetails) {
        Schedule schedule = scheduleRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Schedule not found with id " + id));

        schedule.setNombre(scheduleDetails.getNombre());
        schedule.setDosis(scheduleDetails.getDosis());
        schedule.setHora(scheduleDetails.getHora());
        schedule.setFrecuencia(scheduleDetails.getFrecuencia());
        schedule.setNotas(scheduleDetails.getNotas());
        schedule.setActivo(scheduleDetails.getActivo());

        return scheduleRepository.save(schedule);
    }
}
