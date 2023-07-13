using Random

function spin_initialize( ran, L )
    return rand( ran, [-1,1], (L, L) )
end

function Energy_local( S, L )
    np = [Vector(2:L);1] #周期境界条件
    E = 0
    for ix::Int64 in range(1,L)
        for iy::Int64 in range(1,L)
            hm = S[ix,iy]*(S[np[ix],iy] + S[ix,np[iy]] )
            E -= hm
        end
    end
    return E
end

function magnetization_local( S )
    return sum(S)
end

function Ising_Metropolis( S, L, T, h )
    np = [Vector(2:L);1] #周期境界条件
    nm = [L;Vector(1:L-1)] #周期境界条件

    #確率分布の表を作る
    exps = zeros(Float64, (2, 5))
    for i::Int64 = 1:5
        interact = -4.0 + 2.0*(i-1)
        for j::Int64 = 1:2
            exh = h*(2*(j-1)-1)
            exps[j,i] = exp(-2.0*(interact + exh)/T)
        end
    end

    #Metropolis
    ran = rand( Float64, (L, L)) #L×L行列乱数生成
    for ix = 1:L
        for iy = 1:L
            hm::Int64 = (S[ix,iy]*(S[np[ix],iy] + S[nm[ix],iy] + S[ix,np[iy]] + S[ix,nm[iy]]) + 6) ÷ 2
            if ran[ix,iy] < exps[(S[ix,iy]+3)÷2::Int64, hm]
                S[ix,iy] *= -1
            end
        end
    end
    return S
end

function Ising_Montecarlo_Metropolis(step_equilibration, step_MC, measure_interval, h, T, L)
    ran = MersenneTwister(424) #乱数の種
    count_measure = 0 #測定回数
    E_mean = 0  # エネルギーの時間平均
    E2_mean = 0  # エネルギーの2乗の時間平均
    m_mean = 0  # 磁化の時間平均
    m2_mean = 0 # 磁化の2乗の時間平均
    absm_mean = 0  # 磁化の絶対値の時間平均
    C_mean = 0 # 比熱の平均
    x_mean = 0 # 帯磁率の平均

    S = spin_initialize(ran, L) #スピン初期配置

    #捨てる部分
    for trial = 1:step_equilibration
        S = Ising_Metropolis(S, L, T, h)
    end

    #測定する部分
    for trial = 1:step_MC
        S = Ising_Metropolis(S, L, T, h)
        if trial%measure_interval == 0
            count_measure += 1
            E = Energy_local(S,L)
            E_mean += E
            E2_mean += E^2
            m = magnetization_local(S)
            m_mean += m
            m2_mean += m^2
            absm_mean += abs(m)
        end 
    end

    E_mean /= count_measure
    E2_mean /= count_measure
    m_mean /= count_measure
    m2_mean /= count_measure
    absm_mean /= count_measure

    C_mean = (E2_mean - E_mean^2) / (T*L)^2
    x_mean = (m2_mean - absm_mean^2) / (L)^2
    E_mean /= L^2
    m_mean /= L^2
    absm_mean /= L^2

    return E_mean, m_mean, absm_mean, C_mean, x_mean
end